module Autocuke
  module Handler
    
    def file_modified
      return if runtime.current_file
      runtime.current_file = path
            
      local = path.sub(/.*#{runtime.options.root}\/?/, '')
      cmd   = "cd #{runtime.root}; bundle exec cucumber -p autocuke #{local}"

      puts "#{local} modified - re-cuking it."
      puts cmd if runtime.options.verbose

      operation = proc {
        system(cmd)
      }
      callback = proc {|result|
        runtime.current_file = nil
      }
      EM.defer operation, callback
      
    end
    
    def file_moved
      stop! unless File.exists?(path)
    end
    
    def file_deleted
      if File.exists?(path)
        file_modified
        runtime.watch(path)
      else      
        stop!
      end
    end
    
    def unbind
      #stop!
    end

    private
    
      def runtime
        Autocuke.active_runtime
      end
    
      def stop!
        puts "#{File.basename(path)} is no longer available! Autocuke stopping..."
        runtime.stop!
      end
    
  end
end
