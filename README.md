Autocuke
========

Autocuke uses EventMachine to watch your .feature files, then automatically runs cucumber as they change. Use with spork for total awesomeness.



Installation
------------

If you're using bundler, just add this to your Gemfile:
    
    group :test do
      gem "autocuke", "0.1.0"
    end

Then create a bundle-of-joy with:

    bundle


Otherwise, just install from rubygems like so:

    (sudo) gem install autocuke


That's it!


Usage
-----

First, add an autocuke profile to your `config/cucumber.yml`.

    autocuke: -r features --format pretty --strict


Then boot up the "autocuke-file-watcher-5000":

    autocuke
    

Then 'cuke away... and next time you save your .feature, autocuke will run it for you.


Have fun!


Contributors
------------

So far it's just me; Spencer Steffen. 

If you'd like to help out feel free to fork and send me pull requests!



License
-------

Copyright (c) 2011 Spencer Steffen and Citrus, released under the New BSD License All rights reserved.
