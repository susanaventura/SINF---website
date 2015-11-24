module ImagesHelper

  def get_image_for_product(product)
    (image = Image.find_by(product: product['CodProduct'])) ? 'products/potato.jpeg' : 'photo_not_available.jpg'
  end
end
