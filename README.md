# Monitoring Setup

This Rails application includes comprehensive monitoring with PostgreSQL, Redis, Prometheus, and Grafana.

## Architecture Overview

```
Rails App (3000) → Prometheus (9090) → Grafana (3001)
PostgreSQL (5432) → Postgres Exporter (9187)
Redis (6379) → Redis Exporter (9121)
```

## Key Metrics Monitored

### Application Metrics
- **Response Time**: `http_request_duration_seconds`
- **Request Rate**: `http_requests_total`
- **Error Rate**: HTTP 5xx responses
- **Health Status**: `/health` endpoint

### Database Metrics (PostgreSQL)
- **Connection Count**: `pg_stat_database_numbackends`
- **Query Performance**: `pg_stat_database_blks_read`
- **Database Size**: `pg_database_size_bytes`

### Cache Metrics (Redis)
- **Memory Usage**: `redis_memory_used_bytes`
- **Connection Count**: `redis_connected_clients`
- **Hit Rate**: Cache hits vs misses
- **Key Count**: Total keys in Redis

## Alert Thresholds

### Critical Alerts
- Service Down: Any service unavailable for 5+ minutes
- High Error Rate: >5% HTTP 5xx errors
- Database Connections: >95 connections

### Warning Alerts
- High Response Time: >2 seconds average
- Redis Memory: >80% usage
- Database Size: Rapid growth patterns

## Access Points

- **Rails Application**: http://localhost:3000
- **Grafana Dashboard**: http://localhost:3001 (admin/admin123)
- **Prometheus**: http://localhost:9090
- **Metrics Endpoint**: http://localhost:3000/metrics

## Quick Setup

1. Run `./provision.sh` to start all services
2. Access Grafana to view dashboards
3. Prometheus automatically scrapes metrics
4. Alerts configured in `monitoring/alert_rules.yml`

This setup provides production-ready monitoring for Rails applications with database and cache layers. 