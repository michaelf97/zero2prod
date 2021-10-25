use actix_web::dev::Server;
use actix_web::{web, App, HttpServer};
use routes::*;
use sqlx::PgPool;
use std::net::TcpListener;

pub mod configuration;
pub mod routes;

pub fn run(listener: TcpListener, connection: PgPool) -> Result<Server, std::io::Error> {
    let db_pool = web::Data::new(connection);
    let server = HttpServer::new(move || {
        App::new()
            .route("/health_check", web::get().to(health_check))
            .route("/subscriptions", web::post().to(subscribe))
            .app_data(db_pool.clone())
    })
    .listen(listener)?
    .run();
    Ok(server)
}
