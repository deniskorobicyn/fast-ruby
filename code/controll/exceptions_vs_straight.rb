require 'benchmark/ips'

PARAM = 1

def fast
  PARAM % 2 ? :even : :odd
end

def slow
  PARAM % 2 ? :even : :odd
rescue NoMethodError
  false
end


Benchmark.ips do |x|
  x.report('Meta#without_rescue') { fast }
  x.report('Meta#with_recue') { slow }
  x.compare!
end

