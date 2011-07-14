require_relative '../test_helper'

class RuntimeTest < Test::Unit::TestCase

  def setup
    @features = Dir[File.expand_path("../../dummy/features/**/*.feature", __FILE__)]
  end
    
  context "A new, invalid runtime" do
    
    setup do
      options = OpenStruct.new
      options.root     = File.expand_path("../../dummy/that/doesnt/exist", __FILE__)
      options.features = File.join(options.root, "features")
      options.verbose  = false
      @rt = Autocuke::Runtime.new(options)    
    end

    should "raise error" do
      assert_raises Autocuke::NoFileError do
        @rt.run!
      end
    end

  end


  context "A new, valid runtime" do
    
    setup do
      options = OpenStruct.new
      options.root     = File.expand_path("../../dummy", __FILE__)
      options.features = File.join(options.root, "features")
      options.verbose  = false
      @rt = Autocuke::Runtime.new(options)    
    end

    should "find features" do
      assert_equal @features, @rt.files
    end

    should "start EM reactor" do
      output = capture_stdout do
        EM.run {
          @rt.run!
          EM.stop
        }
      end
      assert_equal "autocuke is up and running!", output.string.strip
    end
    
  end
  
  
  context "The default test runtime" do
  
    should "also start the EM reactor" do
      outputs = within_loop do
        # nothing
      end
      assert_equal "autocuke is up and running!", outputs.first
    end
    
    should "start the EM reactor in verbose mode" do
      outputs = within_loop :verbose => true, do
        # nothing
      end
      assert_equal "Root Set To:", outputs.shift
      assert_equal current_runtime_options.root, outputs.shift
      assert_equal "Watching files:", outputs.shift
      # ignore the line
      outputs.shift
      @features.each do |feature|
        assert_equal feature, outputs.shift
      end
      assert_equal "autocuke is up and running!", outputs.shift
    end
    
  end
end
