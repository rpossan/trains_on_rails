$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'trains_on_rails'
require 'trains_on_rails/route'
require 'trains_on_rails/routes'
require 'trains_on_rails/trip'
require 'trains_on_rails/location'
require 'trains_on_rails/trains_error'
require 'minitest/autorun'
require 'byebug'

INPUT = 'AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7'.freeze
