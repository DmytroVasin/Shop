module UrlHelper
  def home_page
    root_path
  end

  def ad_page(ad)
    "/ads#{ad.slug}"
  end
end