require 'benchmark/ips'
require 'active_support/core_ext/object/try'

class A
  def name
  end
end

#
# ARRAY = (1..10).map do |a|
#   [A.new, nil]
# end.flatten

TEST = A.new

def fast
  TEST.name if TEST.is_a?(A)
end

def slow
  TEST.try(:name)
end

Benchmark.ips do |x|
  x.report('call') { fast }
  x.report('send') { slow }
  x.compare!
end


