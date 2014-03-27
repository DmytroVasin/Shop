def add_gender
  ['Unisex', 'Womens', 'Mens'].each do |type|
    Gender.first_or_create(gender: type)
  end
end
