require_relative '../test_helper'

class AutocukeTest < Test::Unit::TestCase

  def setup
    @bin = File.expand_path("../../../bin/autocuke", __FILE__)    
  end


  def call(options)
    system([ @bin, options ].join(" "))
  end


  
  should "have classes defined" do
    assert defined?(Autocuke)
    assert defined?(Autocuke::Runtime)
    assert defined?(Autocuke::Handler)
  end

  should "have executable" do
    assert File.exists?(@bin)
    assert File.executable?(@bin)    
  end
  
  context "Autocuke help menu" do
  
    setup do
      @output = capture_stdout do 
        call("-h")
      end
    end
  
    should "display help" do
      assert @output.include?("Usage: autocuke [options]")
    end
  
  end
  
end
