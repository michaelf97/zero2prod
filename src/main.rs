use zero2prod::run;
use std::net::TcpListener;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    let listener = TcpListener::bind("127.0.0.1:0").expect("Unable to bind random port");
    println!("Listening on {:?}", listener);
    run(listener)?.await
}