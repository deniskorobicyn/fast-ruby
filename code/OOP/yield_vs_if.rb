# Check code idea represended by Sandi Metz
# https://www.youtube.com/watch?t=46&v=ByURd1SY9dI

require 'benchmark/ips'
require 'activesupport/'

class Object
  def if_true
    yield
    self
  end

  def if_false
    self
  end
end

class NilClass
  def if_true
    self
  end

  def if_false
    yield
    self
  end
end

class FalseClass
  def if_true
    self
  end

  def if_false
    yield
    self
  end
end

ARRAY = (1..100).to_a

def fast
  ARRAY.map do |elem|
    if elem % 2 == 0
      'even'
    else
      'odd'
    end
  end
end

def slow
  ARRAY.map do |elem|
    (elem % 2 == 0).
      if_true{ 'even' }.
      if_false{ 'odd' }
  end
end

Benchmark.ips do |x|
  x.report('simple if') { fast }
  x.report('OOP style') { slow }
  x.compare!
end
