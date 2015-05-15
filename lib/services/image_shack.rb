module ImageShack
  def image_shack_images
    result = image_shack_api_call("#{ENV['image_shack_url']}/images")
    result['images'] unless result.nil?
  end

  def image_shack_albums
    result = image_shack_api_call("#{ENV['image_shack_url']}/albums")
    result['albums'] unless result.nil?
  end

  def thumbnail(direct_link)
    parts = direct_link.split(".")
    length = parts.length
    parts.insert(length - 1, 'th').join('.')
  end

  def image_shack_api_call(url, type = :get, params = {})
    c = Curl::Easy.new
    c.url = "#{url}?#{Curl::postalize(params)}"
    c.method type
    c.ssl_verify_peer = false
    c.perform
    c.response_code == 200 ? JSON.parse(c.body)['result'] : nil
  end
end
