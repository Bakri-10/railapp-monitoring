class MetricsController < ApplicationController
  def index
    metrics = []
    
    # Database status
    begin
      visitor_count = Visitor.count
      metrics << "rails_database_up 1"
      metrics << "rails_visitors_total #{visitor_count}"
    rescue => e
      metrics << "rails_database_up 0"
      metrics << "rails_visitors_total 0"
    end
    
    # Redis status
    begin
      if $redis && $redis.ping == 'PONG'
        metrics << "rails_redis_up 1"
      else
        metrics << "rails_redis_up 0"
      end
    rescue => e
      metrics << "rails_redis_up 0"
    end
    
    # Application uptime (simple timestamp)
    metrics << "rails_app_up 1"
    metrics << "rails_app_startup_time #{Time.now.to_i}"
    
    # Return metrics in Prometheus format
    render plain: metrics.join("\n") + "\n", 
           content_type: 'text/plain; version=0.0.4'
  end
end 