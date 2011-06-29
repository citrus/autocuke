Autocuke
========

#### Since spork + cucumber-rails is [broken](https://github.com/timcharper/spork/issues/122) for the time being, this is the next best thing... and who knows, maybe once it's fixed they'll play nice together! :)

Autocuke uses EventMachine to watch your .feature files, then automatically runs cucumber as they change.



Installation
------------

Autocuke lacks way to many tests to be considered ready for release... but it'll get there. For now just be patient or adventuresome!

If you're feeling up to it, install Autocuke like so...

First, add autocuke to your Gemfile:

    gem "autocuke", :git => "git://github.com/citrus/autocuke.git" 


Then create a bundle-of-joy with:

    bundle


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

Copyright (c) 2011 Spencer Steffen, released under the New BSD License All rights reserved.
