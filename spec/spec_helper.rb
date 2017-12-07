ROOT_PATH = File.expand_path(File.join(File.dirname(__FILE__), '..'))
LIB_PATH = File.join(ROOT_PATH, '/lib')
TDL_PATH = File.join(LIB_PATH, '/test_driven_lighting')

$LOAD_PATH.unshift TDL_PATH

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/"
  end
end
