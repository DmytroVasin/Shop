def add_gender
  ['Unisex', 'Womens', 'Mens'].each do |type|
    Gender.create(gender: type)
  end
end