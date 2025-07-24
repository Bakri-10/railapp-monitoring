class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def health
    status = {
      database: check_database_connection,
      redis: check_redis_connection,
      status: 'ok'
    }

    status[:status] = 'error' unless status[:database] && status[:redis]
    
    render json: status
  end

  private

  def check_database_connection
    begin
      ActiveRecord::Base.connection.active?
    rescue
      false
    end
  end

  def check_redis_connection
    begin
      $redis.with { |conn| conn.ping == 'PONG' }
    rescue
      false
    end
  end
end
