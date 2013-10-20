def add_colors
  ['Black', 'White', 'Red', 'Green'].each do |color|
    Color.create(name: color)
  end
end