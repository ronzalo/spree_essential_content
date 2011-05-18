# install spree and migrate db

say_status "installing", "spree_core, spree_auth"

run "rake spree_core:install spree_auth:install"

say_status "installing", "spree_essentials"
run "rails g spree_essentials:install"