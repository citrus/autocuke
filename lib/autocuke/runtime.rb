require "eventmachine"
require "autocuke/handler"

module Autocuke
  class Runtime
    
    attr_reader   :root,  :options
    attr_accessor :files, :current_file
    
    def initialize(options)
      @options = options
      @root    = options.root
      @files ||= Dir[File.join(options.root, "**/*.feature")]
    end

    # Starts the EM reactor and watches each of the runtime's files
    # Raises an Autocuke::NoFileError if the list of files is empty
    def run!
      raise Autocuke::NoFileError.new("No files given to watch!") if files.empty?

      log if options.verbose

      # file watching requires kqueue on OSX
      EM.kqueue = true if EM.kqueue?

      EM.run {
        watch_feature_files 
        puts "autocuke is up and running!"        
        trap "SIGINT", proc{
          puts "\nbye-bye!"
          exit          
        }
      }      
    end
    
    # Logs the root and file list
    def log
      puts "Root Set To:"
      puts root
      puts         
      puts "Watching files:"
      puts "-" * 88
      puts files
      puts
    end
    
    # Adds each of the runtime's files to EM's file watch list
    def watch_feature_files
      files.each do |file|
        watch(file)
      end 
    end
    
    # Adds a file to EM's file watch list
    def watch(file)
      EM.watch_file(File.expand_path(file), handler)
    end
    
    # Overwrite for custom handlers
    def handler
      Autocuke::Handler
    end
     
  end # Runtime
end # Autocuke
