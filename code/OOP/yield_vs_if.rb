require 'benchmark/ips'
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

# https://www.youtube.com/watch?t=46&v=ByURd1SY9dI

class FalseClass
  def if_true
    self
  end

  def if_false
    yield
    self
  end
end

ARRAY = (1..100).to_a.reverse

def slow
  ARRAY.each do |elem|
    (elem % 2 == 0).
      if_true{ 'even' }.
      if_false{ 'odd' }
  end
end

def fast
  ARRAY.each do |elem|
    if elem % 2 == 0
      'even'
    else
      'odd'
    end
  end
end

Benchmark.ips do |x|
  x.report('fast code description') { fast }
  x.report('slow code description') { slow }
  x.compare!
end
