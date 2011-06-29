require "fileutils"
require "autocuke/runtime"
require "autocuke/version"

module Autocuke
  
  class NoFileError < Exception; end
  
  def self.defaults
    {
      :files => Dir[File.join(Dir.getwd, "features/**/*.feature")]
    }
  end

end
