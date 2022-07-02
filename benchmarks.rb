def test1
  sorted = {}

  File.open("webserver.log").each_line do |line|
    line = line.split()
    sorted[line.first] = 0 if sorted[line.first].nil?
    sorted[line.first] += 1
  end

  sorted
end

def test2
  sorted = {}

  File.readlines("webserver.log").each do |line|
    sorted[line] = 0 if sorted[line].nil?
    sorted[line] += 1
  end

  sorted
end

def test3
  sorted = {}

  File.read("webserver.log").split("\n").each do |line|
    sorted[line] = 0 if sorted[line].nil?
    sorted[line] += 1
    sorted
  end
end

require 'benchmark'
n = 10000

Benchmark.bm do |x|
  x.report('read.split') { n.times { test1 } }
  x.report('readlines') { n.times { test2 } }
  x.report('open.each_line') { n.times { test3 } }
end
