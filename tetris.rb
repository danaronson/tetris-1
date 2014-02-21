#! /usr/bin/env ruby

require 'time'

require './game.rb'
require './algorithms.rb'

width = ARGV[0].to_i
height = ARGV[1].to_i

algorithm_name = ARGV[2].strip

iterations = ARGV[3].to_i

puts "Starting #{iterations} runs on a #{width}x#{height} (1000 max_iter) board with algorithm #{algorithm_name}"

start_time = Time.new
score_accum = 0.0
iter_accum = 0.0
iterations.times.each do 
  game = Game.new(width, height, method(algorithm_name.to_sym), 1000)
  game.run!

  score_accum += game.score
  iter_accum += game.iterations
end

elapsed = Time.new - start_time
average_time = elapsed / iter_accum

average_score = score_accum / iterations


puts "Average score - #{average_score}"
puts "Average execution time - #{1000 * average_time}ms"

