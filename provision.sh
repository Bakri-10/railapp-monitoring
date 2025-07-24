#!/bin/bash

echo "Rails Hello World Provisioning Script"
echo "======================================"

# Check if Docker and Docker Compose are installed
if ! command -v docker &> /dev/null; then
    echo "ERROR: Docker is not installed. Please install Docker first."
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "ERROR: Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Create monitoring directory structure
echo "Creating monitoring directory structure..."
mkdir -p monitoring/grafana/{dashboards,datasources}

# Set proper permissions
echo "Setting permissions..."
chmod +x provision.sh

# Build and start services
echo "Building and starting services..."
docker-compose down --volumes --remove-orphans 2>/dev/null || true

echo "Building Rails application..."
docker-compose build --no-cache web

echo "Starting all services..."
docker-compose up -d

# Wait for services to be healthy
echo "Waiting for services to start up..."
sleep 15

echo "Checking service status..."
docker-compose ps

echo "Waiting for Rails application to be ready..."
# Wait for Rails to be accessible
for i in {1..30}; do
  if curl -f http://localhost:3000 >/dev/null 2>&1; then
    echo "SUCCESS: Rails application is ready!"
    break
  fi
  echo "Attempt $i/30: Rails not ready yet, waiting..."
  sleep 5
done

# Display access information
echo ""
echo "Provisioning complete!"
echo ""
echo "Service URLs:"
echo "   • Rails App:     http://localhost:3000"
echo "   • Grafana:       http://localhost:3001 (admin/admin123)"
echo "   • Prometheus:    http://localhost:9090"
echo "   • Alertmanager:  http://localhost:9093"
echo ""
echo "Database Info:"
echo "   • PostgreSQL:    localhost:5432"
echo "   • Redis:         localhost:6379"
echo ""
echo "Monitoring Endpoints:"
echo "   • Postgres Exporter: http://localhost:9187/metrics"
echo "   • Redis Exporter:    http://localhost:9121/metrics"
echo ""
echo "Rails application is now running with full monitoring stack!" 