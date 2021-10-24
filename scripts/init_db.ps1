# Here we check for already existing credentials. Otherwise, set to default
if ($env:DB_USER -eq $null) { $env:DB_USER="postgres" }
if ($env:DB_PASSWORD -eq $null) { $env:DB_PASSWORD="password" }
if ($env:DB_NAME -eq $null) { $env:DB_NAME="newsletter" }
if ($env:DB_PORT -eq $null) { $env:DB_PORT="5432" }

docker run `
    -e POSTGRES_USER=${env:DB_USER} `
    -e POSTGRES_PASSWORD=${env:DB_PASSWORD} `
    -e POSTGRES_DB=${env:DB_NAME} `
    -p ${env:DB_PORT}:5432 `
    -d `
    postgres

$env:DATABASE_URL="postgres://${env:DB_USER}:${env:DB_PASSWORD}@localhost:${env:DB_PORT}/${env:DB_NAME}"