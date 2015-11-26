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
Image.create!({ product: 'B0003', path: 'products/B0003.jpg' }) 
Image.create!({ product: 'B0007', path: 'products/B0007.jpg' })
Image.create!({ product: 'B0008', path: 'products/B0007.jpg' })  
Image.create!({ product: 'A0007.CASTANHO', path: 'products/castanho.jpg' })  
Image.create!({ product: 'B0004', path: 'products/Ddram2.jpg' }) 
Image.create!({ product: 'A0007.PRETO', path: 'products/preto.jpg' })
Image.create!({ product: 'B0002', path: 'products/rsz_dvd_usb_20.jpg' })  
Image.create!({ product: 'A0005', path: 'products/Table.jpg' }) 
Image.create!({ product: 'XM001', path: 'products/rsz_2montagem.jpg' })
Image.create!({ product: 'TAPETE', path: 'products/rsz_mouse_pad1.jpg' })
Image.create!({ product: 'X0001', path: 'products/rsz_equipmento.jpg' })
#Add entries here