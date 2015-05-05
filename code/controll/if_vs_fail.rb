require 'benchmark/ips'

ARRAY = [ 0, 1, 0, 2, 3, 0, 4, 0]

def fast_with_ternary

  ARRAY.map do |m|
    m == 0 ? 2 : 1.0 / m + 2
  end
end

def fast

  ARRAY.map do |m|
    if m == 0
      2
    else
      1.0 / m + 2
    end
  end

end

def slow
  ARRAY.map do |a|
    begin
      1 / a + 2
    rescue ZeroDivisionError
      2
    end
  end

end

Benchmark.ips do |x|
  x.report('if') { fast }
  x.report('ternary') { fast_with_ternary }
  x.report('rescue') { slow }
  x.compare!
end
