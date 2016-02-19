# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Image.delete_all
Image.create!({ product: 'A0001', path: 'products/pentium_processor.png' })
Image.create!({ product: 'A0002', path: 'products/pentium_processor.png' })
Image.create!({ product: 'A0006', path: 'products/A0006.jpg' }) 
Image.create!({ product: 'A0007', path: 'products/A0007.jpg' }) 
Image.create!({ product: 'A0007.BRANCO', path: 'products/branco.jpg' }) 
Image.create!({ product: 'A0008', path: 'products/A0008.jpg' }) 
Image.create!({ product: 'B0003', path: 'products/monitor_2.jpg' }) 
Image.create!({ product: 'B0007', path: 'products/B0007.jpg' })
Image.create!({ product: 'B0008', path: 'products/B0007.jpg' })  
Image.create!({ product: 'A0007.CASTANHO', path: 'products/castanho.jpg' })  
Image.create!({ product: 'B0004', path: 'products/Ddram2.jpg' }) 
Image.create!({ product: 'A0007.PRETO', path: 'products/preto.jpg' })
Image.create!({ product: 'B0002', path: 'products/rsz_dvd_usb_20.jpg' })  
Image.create!({ product: 'A0005', path: 'products/Table.jpg' }) 
Image.create!({ product: 'B0001', path: 'products/monitor.jpg' }) 
#Add entries here


# Create secondary images
images = Image.all
images.each do |img|
  Image.create!({product: img.product, path: img.path, secondary: true })
  Image.create!({product: img.product, path: img.path, secondary: true })
  Image.create!({product: img.product, path: img.path, secondary: true })
end







Image.create!({ product: 'A0010', path: 'products/teclado_teste_main.jpg' }) 
Image.create!({product: 'A0010', path: 'products/teclado_teste_sec1.jpg', secondary: true })
Image.create!({product: 'A0010', path: 'products/teclado_teste_sec2.jpg', secondary: true })
Image.create!({product: 'A0010', path: 'products/teclado_teste_sec3.jpg', secondary: true })

Image.create!({ product: 'A0011', path: 'products/teclado_teste_main.jpg' }) 
Image.create!({product: 'A0011', path: 'products/teclado_teste_sec1.jpg', secondary: true })
Image.create!({product: 'A0011', path: 'products/teclado_teste_sec2.jpg', secondary: true })
Image.create!({product: 'A0011', path: 'products/teclado_teste_sec3.jpg', secondary: true })

Image.create!({ product: 'A0012', path: 'products/teclado_teste_main.jpg' }) 
Image.create!({product: 'A0012', path: 'products/teclado_teste_sec1.jpg', secondary: true })
Image.create!({product: 'A0012', path: 'products/teclado_teste_sec2.jpg', secondary: true })
Image.create!({product: 'A0012', path: 'products/teclado_teste_sec3.jpg', secondary: true })