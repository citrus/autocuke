class Test::Unit::TestCase

  def default_runtime_options
    options = OpenStruct.new
    options.root     = File.expand_path("../../dummy", __FILE__)
    options.features = File.join(options.root, "features")
    options.verbose  = false
    options
  end
  
  def current_runtime_options
    @current_runtime_options ||= default_runtime_options
  end

  def within_loop(opts={}, &block)
    output = capture_stdout do
      EM.run {
        options = default_runtime_options
        opts.map{ |k,v| options.send("#{k}=", v) }
        @current_runtime_options = options
        Autocuke.start(options)
        yield
        EM.stop
      }
    end
    outputs = output.string.split("\n").select{|i| i && 0 < i.length }
  end

end
