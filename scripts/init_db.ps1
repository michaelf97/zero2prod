# Here we check for already existing credentials. Otherwise, set to default
if ($env:DB_USER -eq $null) { $env:DB_USER="postgres" }
if ($env:PGPASSWORD -eq $null) { $env:PGPASSWORD="password" }
if ($env:DB_NAME -eq $null) { $env:DB_NAME="newsletter" }
if ($env:DB_PORT -eq $null) { $env:DB_PORT="5432" }

docker run `
    -e POSTGRES_USER=${env:DB_USER} `
    -e POSTGRES_PASSWORD=${env:PGPASSWORD} `
    -e POSTGRES_DB=${env:DB_NAME} `
    -p ${env:DB_PORT}:5432 `
    -d `
    postgres

$tries = 0
while ($tries -lt 5) {
    psql -h "localhost" -U "postgres" -p 5432 -d "newsletter" -c '\q' 2>&1
    if ($LASTEXITCODE -ne 0) { 
        $tries += 1 
        Write-Output "Docker not responding..."
        Write-Output "Trying again in 5 seconds!"
        Start-Sleep -Seconds 5
    }
    else {
        break
    }
}

Write-Output "Postgres is up and running on port: $env:DB_PORT"  
$env:DATABASE_URL="postgres://${env:DB_USER}:${env:PGPASSWORD}@localhost:${env:DB_PORT}/${env:DB_NAME}"
sqlx database create
Write-Output "Database '$env:DB_NAME' created!"  