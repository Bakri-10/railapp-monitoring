# Puma configuration file

# Number of processes
workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# Min and Max threads per worker
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { 5 }
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads min_threads_count, max_threads_count

# Default to development
rails_env = ENV.fetch("RAILS_ENV") { "development" }
environment rails_env

# Set up socket location
bind "tcp://0.0.0.0:3000"

# Logging
stdout_redirect "log/puma.stdout.log", "log/puma.stderr.log", true unless rails_env == "development"

# Set master PID and state locations
pidfile ENV.fetch("PIDFILE") { "tmp/puma.pid" }
state_path ENV.fetch("STATEFILE") { "tmp/puma.state" }

# Don't activate control app in development
# activate_control_app

# Allow puma to be restarted by `rails restart` command
plugin :tmp_restart

# Preload app for faster worker spawn
preload_app!

# Before forking the application, handle Redis connections properly
before_fork do
  # Let connection pool handle its own cleanup
  Rails.logger.info "Forking worker process"
end 