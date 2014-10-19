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

    def initialize graph=nil
      @graph = graph
      @calls = []
    end

    def method_missing name, *args
      return super unless METHODS.include?(name)
      add(name, *args)
    end

    def add name, *args
      @calls << { method: name, args: args }
      self
    end

    def follow path
      path.calls.each { |c| @calls << c }
      self
    end

    def + path
      clone.follow(path)
    end

    def all
      add(:all)
      @graph.perform(self)
    end

    def get_limit limit
      add(:get_limit, limit)
      @graph.perform(self)
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
  end

end
