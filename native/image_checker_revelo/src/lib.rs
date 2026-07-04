#[rustler::nif]
fn native_info(file: String) -> Result<String, String> {
    let meta = revelo::Metadata::from_file(&file).unwrap();
    let json = revelo_export::to_json(meta.streams(), &file);
    Ok(json)
}

rustler::init!("Elixir.ImageChecker.Backend.ReveloBindings");
