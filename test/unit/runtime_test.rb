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
      output = within_loop do
        @rt.run!
      end
      assert_equal "autocuke is up and running!\n", output.string
    end
    
  end
end
