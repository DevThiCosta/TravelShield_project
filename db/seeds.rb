User.destroy_all
City.destroy_all
DangerArea.destroy_all
Review.destroy_all

cities_photos = "https://res.cloudinary.com/dkcetjel5/image/upload/v1716668402/fotoRioDeJaneiro_shnysb.jpg"

# Seed Users
10.times do |i|
  User.create!(
    name: Faker::Name.name,
    email: "teste#{i + 1}@teste.com",
    phone_number: Faker::PhoneNumber.phone_number,
    address: Faker::Address.full_address,
    birthday: Faker::Date.birthday(min_age: 18, max_age: 65),
    password: "123456",
    avatar: "https://kitt.lewagon.com/placeholder/users/ssaunier"
  )
end

# Seed Cities
cities = ConectaAddressBr::Cities.by_state_single("RJ")
districts = ["Centro", "Zona Sul", "Zona Norte", "Zona Oeste"]
cities.each do |city|
  City.create!(
    name: city,
    district: districts.sample,
    country: "Brasil",
    state: "RJ",
    safety_tip: "Dica de segurança relevante para #{city}, #{Faker::Lorem.paragraph}",
    safety_tip: Faker::Lorem.paragraph,
    photo: cities_photos

  )
  city.geocode
end

# Seed Danger Areas
city_id = City.where(name: "Rio de Janeiro").first.id
[
  {
    name: "Complexo do Alemão",
    description: "Complexo de favelas localizado na Zona Norte do Rio de Janeiro",
    risk: rand(1..5),
    latitude: 123.456,
    longitude: 789.012
  },
  {
    name: "Cidade de Deus",
    description: "Favela localizada na Zona Oeste do Rio de Janeiro",
    risk: rand(1..5),
    latitude: 456.789,
    longitude: 12.345
  },
  {
    name: "Morro da Providência",
    description: "Favela localizada na região central do Rio de Janeiro",
    risk: rand(1..5),
    latitude: 789.012,
    longitude: 345.678
  },
  {
    name: "Rocinha",
    description: "Favela localizada na Zona Sul do Rio de Janeiro",
    risk: rand(1..5),
    latitude: 987.654,
    longitude: 321.098
  },
  {
    name: "Vidigal",
    description: "Favela localizada na Zona Sul do Rio de Janeiro",
    risk: rand(1..5),
    latitude: 654.321,
    longitude: 890.123
  },
  {
    name: "Maré",
    description: "Complexo de favelas localizado na Zona Norte do Rio de Janeiro",
    risk: rand(1..5),
    latitude: 234.567,
    longitude: 876.543
  },
  {
    name: "Jacarezinho",
    description: "Favela localizada na Zona Norte do Rio de Janeiro",
    risk: rand(1..5),
    latitude: 543.210,
    longitude: 901.234
  },
  {
    name: "Vila Kennedy",
    description: "Favela localizada na Zona Oeste do Rio de Janeiro",
    risk: rand(1..5),
    latitude: 876.543,
    longitude: 345.678
  },
  {
    name: "Ramos",
    description: "Bairro localizado na Zona Norte do Rio de Janeiro",
    risk: rand(1..5),
    latitude: 210.543,
    longitude: 543.210
  },
  {
    name: "Penha",
    description: "Bairro localizado na Zona Norte do Rio de Janeiro",
    risk: rand(1..5),
    latitude: 543.210,
    longitude: 876.543
  }
].each do |danger_area|
  DangerArea.create!(danger_area)
end

# Seed Reviews
User.all.each do |user|
  50.times do
    Review.create!(
      title: Faker::Lorem.sentence,
      rate: rand(1..5),
      comment: Faker::Lorem.paragraph,
      user: user
    )
  end
end
puts "Seed completed!"
