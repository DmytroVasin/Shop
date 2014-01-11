def add_colors_and_image
  ['Black', 'White', 'Red', 'Green'].each do |color|
    Colour.create(name: color)
  end

  Image.create({ small: 'http://www.zappos.com/images/z/2/3/4/9/1/3/2349132-p-MULTIVIEW_THUMBNAILS.jpg',
							 	 	middle: 'http://a1.zassets.com/images/z/2/3/4/9/1/3/2349132-p-MULTIVIEW.jpg',
							   	large: 'http://a2.zassets.com/images/z/2/3/4/9/1/3/2349132-p-4x.jpg'
							})
end