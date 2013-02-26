def add_brands
  File.readlines(File.join(Rails.root, 'db/seeds', 'brands_file')).each do |line|
    Brand.find_or_create_by_name line.strip
  end
end