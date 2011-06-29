require_relative '../test_helper'

class AutocukeTest < Test::Unit::TestCase

  def setup
    @bin = File.expand_path("../../../bin/autocuke", __FILE__)    
    @output = ""
  end


  def call(options)
    puts "#{@bin} #{options}"
    out = `#{@bin} #{options}`
    puts "OUT: #{out}"
    out
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
  
  context "Autocuke options" do
      
    should "display help" do
      @output = call("-h")
      assert @output.include?("Usage: autocuke [options]")
      %w(-r --root -d --dir -v --[no-]verbose -h --help --version).map{|i| assert @output.include?(i) }
    end
  
    should "display version and exit" do
      @output = call("--version")
      assert_equal "autocuke v#{Autocuke::VERSION}\n", @output
    end
  
  end
  
end
