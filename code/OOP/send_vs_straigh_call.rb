require 'benchmark/ips'

class A
  def name
    p 'test'
  end
end

ARRAY = (1..100).to_a

def fast(t)
  t.name
end

def slow(t)
  t.public_send(:name)
end

t = A.new

Benchmark.ips do |x|
  x.report('call') { fast(t) }
  x.report('send') { slow(t) }
  x.compare!
end

