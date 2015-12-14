module ImagesHelper

  def get_image_for_product(product)
    return (image = Image.find_by(product: product['CodProduct'], secondary: false)) ? image.path : 'photo_not_available.jpg'
  end

  def get_images_for_product(product)
    image = Image.find_by(product: product['CodProduct'], secondary: false)
    sec_images = []
    Image.where(product: product['CodProduct'], secondary: true).all.each do |img|
      puts 'a'
      sec_images = sec_images.push(img.path)
    end

    return {main_image: image ? image.path : 'photo_not_available.jpg', secondary_images: sec_images}
  end

end
