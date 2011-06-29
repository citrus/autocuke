require "eventmachine"
require "autocuke/handler"

module Autocuke
  class Runtime
    
    attr_reader   :options
    attr_accessor :files
    
    def initialize(options)
      @options = options
      @files ||= Dir[File.join(options.root, "**/*.feature")]
    end

    def run!
      raise Autocuke::NoFileError.new("No files given to watch!") if files.empty?

      if options.verbose
        puts "Watching files:"
        puts "-" * 88
        puts files
      end
      
      # file watching requires kqueue on OSX
      EM.kqueue = true if EM.kqueue?
      
      EM.run {
        files.each do |file|
          watch(file)
        end        
      }
      
    end
    
    def stop!
      EM.stop_event_loop
    end
    
    def watch(file)
      EM.watch_file(File.expand_path(file), Autocuke::Handler)
    end
     
  end # Runtime
end # Autocuke
