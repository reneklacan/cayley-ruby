module Cayley

  class Graph
    API_PATH = '/api/v1/query/gremlin'


    def initialize params
      @host = params[:host] || 'localhost'
      @port = params[:port] || 64210
      @debug = params[:debug] || false
      @result_wrapper = params[:result_wrapper] || Hashie::Mash
    end

    def query
      Query.new(self)
    end

    def vertex *args
      Path.vertex(self, *args)
    end

    alias_method :v, :vertex

    def morphism
      Path.morphism(self)
    end

    alias_method :m, :morphism

    def perform query
      constructed = query.construct
      puts "DEBUG - Query: #{constructed}" if @debug
      results = request(constructed)

      if results && @result_wrapper
        results.map{ |r| @result_wrapper.new(r) }
      else
        results
      end
    end

    protected

    def request data
      url = "http://#{@host}:#{@port}#{API_PATH}"
      r = Curl::Easy.new(url) do |curl|
        curl.headers["User-Agent"] = "curb-#{Curl::VERSION}"
        #curl.verbose = true
      end
      r.http_post(data)
      JSON.load(r.body_str)['result']
    end
  end

end
