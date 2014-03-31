def add_gender
  {:'Unisex'=> 'Унисекс', :'Womens' => 'Женское', :'Mens'=> 'Мужское'}.each do |type, rus|
    Gender.first_or_create({ gender: type, gender_rus: rus })
  end
end
