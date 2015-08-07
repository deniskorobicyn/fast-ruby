require 'benchmark/ips'

ARRAY = [*1..1000]
PARAM = 1

def fast
  ARRAY.each do |n|
    if PARAM % 2
      odd(n)
    else
      even(n)
    end
  end
end

def slow
  method = PARAM % 2 ? :even : odd

  ARRAY.each do |n|
    send(method, n)
  end
end

def odd(n)
  "#{n} is odd"
end

def even(n)
  "#{n} is even"
end

Benchmark.ips do |x|
  x.report('Meta#if') { fast }
  x.report('Meta#send') { slow }
  x.compare!
end
