# require gems
require 'bundler/setup'
require 'shoulda'
require 'autocuke'

EM.kqueue = EM.kqueue?

# require support
Dir[File.expand_path("../support/**/*.rb", __FILE__)].map{ |f| require f }
