class Test::Unit::TestCase

  def within_loop(&block)
    output = capture_stdout do
      EM.run {
        Autocuke.start(@options)
        yield
        EM.stop
      }
    end
    outputs = output.string.split("\n")
  end

end
