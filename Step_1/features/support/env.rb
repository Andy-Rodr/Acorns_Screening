require 'rubygems'
require 'bundler/setup'
require 'capybara'
require 'capybara/dsl'
require 'rspec'
require 'site_prism'
 
Capybara.run_server = false
#Set default driver as Selenium
Capybara.default_driver = :selenium
#Set default selector as css
Capybara.default_selector = :css
 
#Syncronization related settings
module Helpers
  def without_resynchronize
    page.driver.options[:resynchronize] = false
    yield
    page.driver.options[:resynchronize] = true
  end
end

World(Capybara::DSL, Helpers)