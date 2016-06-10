# this file is automatically required when you run `assert`
# put any test helpers here

# add the root dir to the load path
$LOAD_PATH.unshift(File.expand_path("../..", __FILE__))

# require pry for debugging (`binding.pry`)
require 'pry'

require 'test/support/factory'

require 'pathname'
TEST_SUPPORT_PATH = Pathname.new(File.expand_path('../support', __FILE__))

# 1.8.7 backfills

# Array#sample
if !(a = Array.new).respond_to?(:sample) && a.respond_to?(:choice)
  class Array
    alias_method :sample, :choice
  end
end
