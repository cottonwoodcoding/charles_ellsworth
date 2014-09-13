if Rails.env == 'development'
  begin
    album_map = "#{Rails.root}/config/albums.yml"
    albums = YAML.load_file(album_map)
    ENV['ALBUMS'] = albums.to_json
  rescue
    raise 'There is no album config'
  end
end
