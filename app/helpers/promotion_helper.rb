module PromotionHelper
  def album_art_image_path(image_name)
    image_name = 'not_found' unless image_name
    File.exists?("#{Rails.root}/app/assets/images/album_art/#{image_name}") ? "assets/album_art/#{image_name}" : "assets/album_art/no_album_art.jpeg"
  end
end
