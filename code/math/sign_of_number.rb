require 'benchmark/ips'

NUMBERS = [100, -2, 0]*5

def fast
  NUMBERS.map { |x| x <=> 0 }
end

def slow
  NUMBERS.map do |n|
    case
    when n > 0
      1
    when n < 0
      -1
    else
      0
    end
  end
end

Benchmark.ips do |x|
  x.report("Math#<=>")   { fast }
  x.report("Math#case") { slow }
  x.compare!
end
