if Rails.env == 'development'
  begin
    picasa_file = "#{Rails.root}/config/picasa.yml"
    picasa_config = YAML.load_file(picasa_file)
    picasa_config.each { |key, value| ENV[key] = value }
  rescue
    ''
  end
end
