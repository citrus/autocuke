require "eventmachine"
require "autocuke/handler"

module Autocuke
  class Runtime
    
    attr_reader   :root, :options
    attr_accessor :files, :current_file
    
    def initialize(options)
      @options = options
      @root    = options.root
      @files ||= Dir[File.join(options.root, "**/*.feature")]
    end

    def run!
      raise Autocuke::NoFileError.new("No files given to watch!") if files.empty?

      if options.verbose
        puts "Root Set To:"
        puts root
        puts         
        puts "Watching files:"
        puts "-" * 88
        puts files
        puts
      end

      # file watching requires kqueue on OSX
      EM.kqueue = true if EM.kqueue?

      EM.run {
        files.each do |file|
          watch(file)
        end  
        puts "autocuke is up and running!"
        
        trap "SIGINT", proc{
          puts "\nbye-bye!"
          exit          
        }
      }
      
    end
    
    def stop!
      EM.stop
    end
    
    def watch(file)
      EM.watch_file(File.expand_path(file), Autocuke::Handler)
    end
     
  end # Runtime
end # Autocuke
