module Autocuke
  module Handler
    
    def file_modified
      puts "#{File.basename(path)} modified - re-cuking it."
      system("bundle exec cucumber #{path}")
    end
    
    def file_moved
      stop! unless File.exists?(path)
    end
    
    def file_deleted
      if File.exists?(path)
        file_modified
        Autocuke.active_runtime.watch(path)
      else      
        stop!
      end
    end
    
    def unbind
      #stop!
    end

    private
    
      def stop!
        puts "#{File.basename(path)} is no longer available! Autocuke stopping..."
        Autocuke.active_runtime.stop!
      end
    
  end
end
