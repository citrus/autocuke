require "ostruct"
require "fileutils"
require "autocuke/runtime"
require "autocuke/version"

module Autocuke
  
  class NoFileError < Exception; end
  
  def self.start(options)
    @active_runtime = Runtime.new(options)
    @active_runtime.run!
  end
  
  def self.set_active_runtime(runtime)
    @active_runtime = runtime
  end
  
  def self.active_runtime
    @active_runtime
  end
  
end
