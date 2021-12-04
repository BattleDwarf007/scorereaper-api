# scorereaper-api

This backedn API is required when using the android app: https://github.com/BattleDwarf007/scorereaper-scanner

## Requirements
* Database server (MariaDB)
* User with execute permissions on the database

## Setup
Create the necesarry tables and stored procedures using the [sql script](./database/db.sql)
Update the [config file](config.yml) with the database server information:
```yaml
databaseconfig:
  dbserver: <database server IP or hostname>
  dbport: 3306
  database: <databasename>
```

Due to not implementing the vault functionality yet update the connection string in [repository.go](./repository/repository.go)
```go
connectionString = fmt.Sprintf("user:password@tcp(%s:%s)/%s?parseTime=true&multiStatements=true", dbHost, dbPort, database)
```


___
CREDITS:
 - The API is build on the Go platform [goslow](https://github.com/Mallekoppie/goslow) created by [Heinrich Barnard](https://github.com/Mallekoppie)