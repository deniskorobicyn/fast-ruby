require 'benchmark/ips'
require 'active_support/core_ext/object/try'
$: <<  File.expand_path(File.dirname(__FILE__))

def fast
  load 'attr_reader_class.rb'
end

def slow
  load 'def_class.rb'
end

Benchmark.ips do |x|
  x.report('def')         { slow }
  x.report('attr_reader') { fast }
  x.compare!
end
