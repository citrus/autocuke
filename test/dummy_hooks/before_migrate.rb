run "rails generate cucumber:install"

run "rails generate cucumber:feature post title:string body:text published:boolean"
run "rails generate scaffold post title:string body:text published:boolean"

run "rails generate cucumber:feature comment post:references name:string body:text"
run "rails generate scaffold comment post:references name:string body:text"

append_file "config/cucumber.yml", "\nautocuke: -r features --format pretty --strict"
