Fabricator(:review) do
  body { Faker::Lorem.sentence(3) }
  star_rating { Faker::Number.between(1, 5) }
end
