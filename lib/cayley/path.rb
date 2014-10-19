module Cayley

  class Path
    attr_accessor :calls

    METHODS = [
      :out, :in, :both, :is, :has, # basic
      :tag, :back, :save, # tags
      :intersect, :union, # joining
      :and, :or, # joining aliases
    ]

    def self.vertex graph, *args
      path = Path.new(graph)
      path.calls = [{ method: :vertex, args: args }]
      path
    end

    def self.morphism graph
      Path.new(graph)
    end

    def initialize graph=nil, calls=[]
      @graph = graph
      @calls = calls
    end

    def method_missing name, *args
      return super unless METHODS.include?(name)
      path = Path.new(@graph, @calls.dup)
      path.add(name, *args)
    end

    def add name, *args
      @calls << { method: name, args: args }
      self
    end

    def follow path
      Path.new(@graph, @calls.dup + path.calls)
    end

    def + path
      follow(path)
    end

    def all
      copy.add(:all).perform
    end

    def get_limit limit
      copy.add(:get_limit, limit).perform
    end

    def limit l
      get_limit(l)
    end

    def construct
      calls = @calls.map do |call|
        m = call[:method].to_s.camelize
        as = (call[:args] || []).map{ |a| "\"#{a}\"" }.join(", ")
        "#{m}(#{as})"
      end
      'graph.' + calls.join('.')
    end

    def perform
      @graph.perform(self)
    end

    def copy
      Path.new(@graph, @calls.dup)
    end
  end

end
