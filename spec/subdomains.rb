# require 'rails_helper'
# require_relative '../app/controllers/api/v1/profiles_controller'
#
# DEFAULT_HOST = "lvh.me"
# DEFAULT_PORT = 9887
#
# RSpec.configure do |config|
#   Capybara.default_host = "http://#{DEFAULT_HOST}"
#   Capybara.server_port = DEFAULT_PORT
#   Capybara.app_host = "http://#{DEFAULT_HOST}:#{Capybara.server_port}"
# end
#
# def switch_to_subdomain(subdomain)
#     @controller = Api::V1::ProfilesController.new
#    Capybara.app_host = "http://#{subdomain}.#{DEFAULT_HOST}:#{DEFAULT_PORT}"
# end
