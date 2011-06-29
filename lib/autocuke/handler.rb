module Autocuke
  module Handler
    def file_modified
      puts "#{path} modified"
    end
    
    def file_moved
      puts "#{path} moved"
    end
    
    def file_deleted
      puts "#{path} deleted"
    end
    
    def unbind
      puts "#{path} monitoring ceased"
    end
  end
end
