def add_gender
  ['Women', 'Men', 'Girls', 'Boys'].each do |type|
    Gender.create(gender: type)
  end
end