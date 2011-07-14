module Autocuke
  module Handler

    # Triggered after a file has been modified
    def file_modified
      return if runtime.current_file
      runtime.current_file = path
      local = path.sub(/.*#{runtime.options.root}\/?/, '')
      cmd   = "cd #{runtime.root}; bundle exec cucumber -p autocuke #{local}"
      puts "#{local} modified - re-cuking it."
      run_with_defer cmd      
    end
    
    # Triggered after a file has been moved
    def file_moved
      stop! unless File.exists?(path)
    end
    
    # Triggered after a file has been deleted.
    # In text editors, the file is deleted and recreated rather than modified.
    # If so, we'll start watching the new file and trigger `file_modified`
    def file_deleted
      if File.exists?(path)
        file_modified
        runtime.watch(path)
      else      
        stop!
      end
    end
    
    # Stop EM if the file doesn't exist
    def unbind
      stop! unless File.exists?(path)
    end

    private
    
      # Runs the cucumber command and triggers a callback when it's complete
      def run_with_defer(cmd)
        puts cmd if runtime.options.verbose
        operation = proc {
          system(cmd)
        }
        callback = proc {|result|
          runtime.current_file = nil
        }
        EM.defer operation, callback
      end
    
      # Just an alias to the active runtime
      def runtime
        Autocuke.active_runtime
      end
    
      # Warns the user and stops the active runtime
      def stop!
        puts "*" * 88
        puts "#{File.basename(path)} is no longer available! Autocuke stopping..."
        runtime.stop!
      end
    
  end
end
