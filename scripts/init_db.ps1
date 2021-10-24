# Here we check for already existing credentials. Otherwise, set to default
# could use $DB_USER ??= "postgres" but only supports PS Version 7
if ($DB_USER -eq $null) { $DB_USER="postgres" }
if ($DB_PASSWORD -eq $null) { $DB_PASSWORD="password" }
if ($DB_NAME -eq $null) { $DB_NAME="newsletter" }
if ($DB_PORT -eq $null) { $DB_PORT="5432" }

docker run `
    -e POSTGRES_USER=${DB_USER} `
    -e POSTGRES_PASSWORD=${DB_PASSWORD} `
    -e POSTGRES_DB=${DB_NAME} `
    -p ${DB_PORT}:5432 `
    postgres