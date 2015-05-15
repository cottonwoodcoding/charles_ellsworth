image_shack = "#{Rails.root}/config/image_shack.yml"
if File.exists? image_shack
  config = YAML.load_file(image_shack)
  config.each { |key, value| ENV[key] || ENV[key] = value.to_s }
end
