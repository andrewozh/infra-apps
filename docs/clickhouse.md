# Clickhouse

## Self-hosted Altinity Clickhouse and Clickhouse Cloud compatibility

Cloud:
- `default` cluster can't be used
- create database without ON CLUSTER
- than use database name as cluster name while creating tables, views, etc. ON CLUSTER
- use custom zookeeper path without {uuid} (because it's not supported by self-hosted)
- always specify Replicated table engine
