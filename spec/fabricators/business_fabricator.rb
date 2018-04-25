Fabricator(:business) do
  name { Faker::Commerce.department }
  address { Faker::Address.street_name }
  zip_code '06516'
  price_range '$$'
  phone_number '5556667777'
end
