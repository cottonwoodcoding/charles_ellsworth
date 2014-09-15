if Rails.env == 'development'
  begin
    email_config = YAML.load(File.read(File.expand_path("#{Rails.root}/config/email.yml", __FILE__)))
    email_config.each { |key, value| ENV[key] = value }
  rescue
    raise "There is no email config."
  end
end
