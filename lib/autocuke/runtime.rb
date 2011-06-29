require "eventmachine"
require "autocuke/handler"

module Autocuke
  class Runtime
    
    def initialize(options={})
      puts "HELLO!"
      puts options.inspect
      super
    end
    
    def run!
      puts "OMG!?!"

      # file watching requires kqueue on OSX
      EM.kqueue = true if EM.kqueue?
      
      EM.run {
        EM.watch_file("/tmp/foo", Autocuke::Handler)
      }
       
    end
    
  end # Runtime
end # Autocuke
