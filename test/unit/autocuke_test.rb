require_relative '../test_helper'

class AutocukeTest < Test::Unit::TestCase

  def setup
    
  end
  
  should "have classes defined" do
    assert defined?(Autocuke)
    assert defined?(Autocuke::Runtime)
    assert defined?(Autocuke::Handler)
  end
  
end
