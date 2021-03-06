require_relative '../test_helper'


# Extends the original handler
module MockHandler
  
  include Autocuke::Handler        
  
  def file_modified
    $modified = true
    super
  end
  
  private   
     
    # don't run, just output the command
    def run_with_defer(cmd)
      operation = proc {
        puts(cmd)
        # simulate delay
        #sleep 0.25
      }
      callback = proc {|result|
        runtime.current_file = nil
      }
      EM.defer operation, callback
    end
    
end


# use the MockHandler
module Autocuke
  class Runtime
    def handler
      ::MockHandler
    end
  end
end


class HandlerTest < Test::Unit::TestCase

  def setup
    $modified = false
    @features = Dir[File.expand_path("../../dummy/features/**/*.feature", __FILE__)]
    @options = OpenStruct.new
    @options.root     = File.expand_path("../../dummy", __FILE__)
    @options.features = File.join(@options.root, "features")
    @options.verbose  = false
  end
    
  should "watch a file" do
    
    outputs = within_loop do
      File.open(@features.first, 'w+'){ |f| f.write "\n" }
    end
    
    # disregard the start-up message
    outputs.shift
    
    assert $modified
    
    name = File.basename(@features.first)
    assert_equal "features/#{name} modified - re-cuking it.", outputs.shift
    
    commands = outputs.shift.split("; ")
    assert_equal "cd #{@options.root}", commands.first
    assert_equal "bundle exec cucumber -p autocuke features/#{name}", commands.last
  end

end
