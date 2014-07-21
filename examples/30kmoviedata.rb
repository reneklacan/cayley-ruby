# -*- encoding : utf-8 -*-

$:.push File.expand_path('../lib', __FILE__)

require 'cayley'

p graph = Cayley::Graph.new(host: 'localhost', port: 64210, debug: true)

p graph.vertex.get_limit(5)

p graph.vertex('Humphrey Bogart').all

p graph.v('Humphrey Bogart').all

p graph.v('Humphrey Bogart').in('name').all

p graph.v('Casablanca').in('name').all

p graph.v.has('name', 'Casablanca').all

p graph.v
       .has('name', 'Casablanca')
       .out('/film/film/starring')
       .out('/film/performance/actor')
       .out('name')
       .all

film_to_actor = graph.morphism
                     .out('/film/film/starring')
                     .out('/film/performance/actor')

p graph.v
       .has('name', 'Casablanca')
       .follow(film_to_actor)
       .out('name').all
