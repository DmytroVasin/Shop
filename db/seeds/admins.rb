def add_admin
  Admin.first_or_create(email: 'nick-supernick@gmail.com', password: 'epyfnm')
end
