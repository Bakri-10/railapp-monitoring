# Be sure to restart your server when you modify this file.

# Secret key for verifying the integrity of signed cookies
# Uses environment variable for security
RailsStarter::Application.config.secret_token = ENV['SECRET_TOKEN'] || 'f42f40d1d8f4de155e932dd736d71682de518445d5d9250394198aa95d106797fc63c85e8af4baae91105992fff49b1c73eaaf89aa4b217c76413313b5023568'
