require 'benchmark/ips'

NUMBERS = [1, 2, 3, 4, 0, -4, 5] * 10
def fast
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

def slow
  NUMBERS.map do |n|
    if n > 0
      1
    elsif n < 0
      -1
    else
      0
    end
  end
end


Benchmark.ips do |x|
  x.report("Control#case")   { fast }
  x.report("Control#if") { slow }
  x.compare!
end
