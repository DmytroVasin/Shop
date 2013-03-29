module UrlHelper
  def home_page
    '/'
  end

  def ad_page(ad)
    "/ads#{ad.slug}"
  end
end