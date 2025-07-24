require 'json'

class SayController < ApplicationController
  def hello
    # Record visitor for database demonstration
    begin
      Visitor.record_visit(request.remote_ip, request.user_agent)
    rescue StandardError => e
      Rails.logger.warn "Could not record visitor: #{e.message}"
    end
    
    # Cache demonstration with Redis
    @visitor_count = Rails.cache.fetch('visitor_count', expires_in: 5.minutes) do
      Visitor.count
    end
    
    @yourip = request.remote_ip
    @ruby_version = RUBY_VERSION
    @rails_version = Rails::VERSION::STRING
    
    # Database status check
    @database_connected = begin
      ActiveRecord::Base.connection.active?
    rescue ActiveRecord::ConnectionNotEstablished => e
      Rails.logger.warn "Database connection error: #{e.message}"
      false
    end
    
    # Redis status check
    @redis_connected = begin
      if defined?($redis) && $redis
        $redis.with { |conn| conn.ping == 'PONG' }
      else
        false
      end
    rescue => e
      Rails.logger.warn "Redis connection error: #{e.message}"
      false
    end
    
    # Recent visitors for database demonstration
    @recent_visitors = begin
      Visitor.recent.limit(5)
    rescue StandardError => e
      Rails.logger.warn "Could not fetch recent visitors: #{e.message}"
      []
    end
    
    # Environment variable parsing and display
    env = {}
    ENV.each do |key, value|
      begin
        obj = JSON.parse(value)
        env[key] = JSON.pretty_generate(obj)
      rescue JSON::ParserError => e
        env[key] = value
      end
    end
    @env = env
  end
end
