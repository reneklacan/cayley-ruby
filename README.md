# cayley-ruby

A ruby library for working with
[Google's Cayley](https://github.com/google/cayley)
graph database.

## Installation

You can install it via gem

```bash
gem install cayley
```

## Usage

Start your Cayley

```bash
# example using 30kmoviedata from cayley's repository
./cayley http --dbpath=30kmoviedata.nt
```

You can use methods from
[Gremlin API documentation](https://github.com/google/cayley/blob/master/docs/GremlinAPI.md), just translate method names to snake style equivalent.

As a first step you need to create your client

```ruby
require 'cayley'

graph = Cayley::Graph.new

# or

graph = Cayley::Graph.new(host: 'localhost', port: 64210)
```

Then using **30kmovies.nt** db from cayley's repository you can do this

```ruby
graph.vertex.get_limit(5)

graph.vertex('Humphrey Bogart').all

graph.v('Humphrey Bogart').all

graph.v('Humphrey Bogart').in('name').all

graph.v('Casablanca').in('name').all

graph.v().has('name', 'Casablanca').all
```

You can also use morphism

```
film_to_actor = graph.morphism
                     .out('/film/film/starring')
                     .out('/film/performance/actor')
graph.v
     .has('name', 'Casablanca')
     .follow(film_to_actor)
     .out('name').all
```

For more info take a look at
[Cayley's repository](https://github.com/google/cayley)

## Advanced

By default result of your queries are wrapped in Hashie::Mash so you can
do things like these

```ruby
graph.v.all.each do |result|
  puts result.id # instead of result['id']
end
```

If you want to use plain ruby hashes you can disable wrapping by

```ruby
graph = Cayley::Graph.new(result_wrapper: nil)
```

Or you can use some custom wrapper if you put class instead of nil.

## Debugging

If you are not sure why you are getting nil as a result of your query
and you are not able to find out the solution you can turn on debug mode
where used Gremlin query is printed out.

```ruby
graph = Cayley::Graph.new(debug: true)
```

## TODO

* logger
* tests
