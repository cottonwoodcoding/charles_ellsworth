if Rails.env == 'development'
  begin
    do_file = YAML.load "#{Rails.root}/config/do.yml"
    digital_ocean = YAML.load_file(do_file)
    digital_ocean.each { |key, value| ENV[key] || ENV[key] = value.to_s }
  rescue
    raise 'There is no digitial ocean config'
  end
end
