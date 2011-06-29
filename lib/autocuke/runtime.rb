require "eventmachine"
require "autocuke/handler"

module Autocuke
  class Runtime
    
    attr_reader :options
    
    def initialize(options={})
      @options = Autocuke.defaults.merge(options)
      puts "HELLO!"
      puts options.inspect
      super
    end
    
    def run!
      raise Autocuke::NoFileError.new("No files given to watch!") unless files = options[:files]
    
      puts "OMG!?!"
      puts files.inspect

      # file watching requires kqueue on OSX
      EM.kqueue = true if EM.kqueue?
      
      EM.run {
        EM.watch_file("/tmp/foo", Autocuke::Handler)
      }
       
    end
    
  end # Runtime
end # Autocuke
