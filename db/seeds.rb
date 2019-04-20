# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.create!(name: "Costume",
  description: "Ao quan")
Category.create!(name: "Helmet",
  description: "Mu bao hiem")
Category.create!(name: "Accessories",
  description: "Phu kien") #1 con sẽ có parent_id=category_id của cha
Category.create!(name: "Balo & bag",
  description: "Balo va tui xach")
Category.create!(name: "Clothes",
  description: "Clothes",
  parent_id: 1)
Category.create!(name: "Helmet_34",
  description: "Helmet 3/4",
  parent_id: 2)
Category.create!(name: "Gloves",
  description: "Gloves",
  parent_id: 3)
Category.create!(name: "Balo",
  description: "Balo",
  parent_id: 4)
10.times do |n|
  product_name  = "Helmet fullface-#{n+1}"
  product_image = "/assets/mu-1.jpg"
  product_details = "Mũ bảo hiểm 3/4 Royal M20
- Sản xuất: Việt Nam
- Size: M (54cm-56cm); L (57cm-59cm)
- Trọng lượng: 850 gram
- Vỏ bằng nhựa ABS nguyên sinh – là loại nhựa tinh khiết chưa qua sử dụng, được sử dụng cho các sản phẩm tiêu chuẩn an toàn cao vỏ thiết bị y tế, dược phẩm…. có độ bền cao và chịu va đập tốt.
- Phần đệm lót bên trong nón còn có lớp vải kháng khuẩn, chống ẩm, rất tốt cho việc bảo vệ chiếc nón khỏi mùi hôi, ẩm mốc. Vải nón nhiều màu sắc làm nón trông sang trọng và nổi bật",
  price_normal= 370000+n
  price_sale_off= 0
  Product.create!(product_name: product_name,
  product_image: product_image,
  product_details: product_details,
  price_normal: price_normal,
  price_sale_off: price_sale_off,
  quanlity: 30,
  category_id: 6
  )
end
10.times do |n|
  product_name  = "Costume -#{n+1}"
  product_image = "/assets/ao-biker-1.jpg"
  product_details = "Áo giáp thân Pro biker - AG3:

- Các lớp nhựa ở vai, cùi chỏ, lưng và ngực chịu được tác động vật lý cao
- Áo được may liên kết với các phần giáp nhựa bằng thun tạo cảm giác êm ái thoải mái
- Dây đai điều chỉnh bộ phận bảo vệ lưng đảm bảo độ an toàn tuyệt đối."
  price_normal= 500000+n*10
  price_sale_off= 0
  Product.create!(product_name: product_name,
  product_image: product_image,
  product_details: product_details,
  price_normal: price_normal,
  price_sale_off: price_sale_off,
  quanlity: 30,
  category_id: 5
  )
end
10.times do |n|
  product_name  = "Accessories -#{n+1}"
  product_image = "/assets/giay-di-mua-1.jpg"
  product_details = "Mùa mưa đến nên mọi người đều rất ngại đi ra đường. Tuy nhiên vì công việc phải thường xuyên đi ngoài đường nên không thể tránh khỏi mưa ướt. Việc đi cả ngày ngoài đường với đôi giày ướt sẽ làm cho bạn khó chịu, bị nấm chân, nước ăn châm."
  price_normal= 500000+n*10
  price_sale_off= 0
  Product.create!(product_name: product_name,
  product_image: product_image,
  product_details: product_details,
  price_normal: price_normal,
  price_sale_off: price_sale_off,
  quanlity: 30,
  category_id: 7
  )
end
10.times do |n|
  product_name  = "Balo & bag -#{n+1}"
  product_image = "/assets/balo-chong-nuoc-1.jpg"
  product_details = "Balo chống nước 30L GIVI Prime BackPack PBP01 là sản phẩm rất hữu dụng cho người đi dã ngoại, nhất là các bike, khi du ngoạn trên từng cung đường, giúp gói gọn đồ đạc của bạn trong một balo tiện lợi và đảm bảo khô ráo."
  price_normal= 500000+n*10
  price_sale_off= 0
  Product.create!(product_name: product_name,
  product_image: product_image,
  product_details: product_details,
  price_normal: price_normal,
  price_sale_off: price_sale_off,
  quanlity: 30,
  category_id: 8
  )
end
