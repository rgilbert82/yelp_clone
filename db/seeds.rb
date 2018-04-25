# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ca = State.create(name: "CA")
wa = State.create(name: "WA")
oregon = State.create(name: "OR")

la = City.create(name: "Los Angeles", state: ca)
san_fran = City.create(name: "San Francisco", state: ca)
seattle = City.create(name: "Seattle", state: wa)
portland = City.create(name: "Portland", state: oregon)

restaurants = Category.create(name: "Restaurants", icon_class: "glyphicon-cutlery")
nightlife = Category.create(name: "Nightlife", icon_class: "glyphicon-glass")
home_services = Category.create(name: "Home Services", icon_class: "glyphicon-wrench")

burgers = SubCategory.create(name: "Hamburgers", category: restaurants)
fast_food = SubCategory.create(name: "Fast Food", category: restaurants)
SubCategory.create(name: "American (New)", category: restaurants)
SubCategory.create(name: "American (Traditional)", category: restaurants)
SubCategory.create(name: "Breakfast & Brunch", category: restaurants)
SubCategory.create(name: "Cafes", category: restaurants)
SubCategory.create(name: "Chinese", category: restaurants)
SubCategory.create(name: "Delis", category: restaurants)
SubCategory.create(name: "Food Stands", category: restaurants)
SubCategory.create(name: "Italian", category: restaurants)
SubCategory.create(name: "Japanese", category: restaurants)
SubCategory.create(name: "Mexican", category: restaurants)
SubCategory.create(name: "Pizza", category: restaurants)
SubCategory.create(name: "Salad", category: restaurants)
SubCategory.create(name: "Sandwiches", category: restaurants)
seafood = SubCategory.create(name: "Seafood", category: restaurants)
SubCategory.create(name: "Sushi Bars", category: restaurants)
SubCategory.create(name: "Vietnamese", category: restaurants)

SubCategory.create(name: "Adult Entertainment", category: nightlife)
SubCategory.create(name: "Bar Crawl", category: nightlife)
bars = SubCategory.create(name: "Bars", category: nightlife)
SubCategory.create(name: "Beer Gardens", category: nightlife)
SubCategory.create(name: "Club Crawl", category: nightlife)
SubCategory.create(name: "Comedy Clubs", category: nightlife)
SubCategory.create(name: "Country Dance Halls", category: nightlife)
SubCategory.create(name: "Dance Clubs", category: nightlife)
SubCategory.create(name: "Jazz & Blues", category: nightlife)
SubCategory.create(name: "Karaoke", category: nightlife)
music_venues = SubCategory.create(name: "Music Venues", category: nightlife)
piano_bars = SubCategory.create(name: "Piano Bars", category: nightlife)
SubCategory.create(name: "Pool Halls", category: nightlife)

SubCategory.create(name: "Building Supplies", category: home_services)
contractors = SubCategory.create(name: "Contractors", category: home_services)
SubCategory.create(name: "Electricians", category: home_services)
SubCategory.create(name: "Flooring", category: home_services)
SubCategory.create(name: "Gardeners", category: home_services)
SubCategory.create(name: "Handyman", category: home_services)
heating = SubCategory.create(name: "Heating & AC", category: home_services)
SubCategory.create(name: "Home Cleaning", category: home_services)
SubCategory.create(name: "Interior Design", category: home_services)
SubCategory.create(name: "Keys & Locksmiths", category: home_services)
SubCategory.create(name: "Landscaping", category: home_services)
SubCategory.create(name: "Movers", category: home_services)
SubCategory.create(name: "Painters", category: home_services)
plumbing = SubCategory.create(name: "Plumbing", category: home_services)
SubCategory.create(name: "Real Estate", category: home_services)
SubCategory.create(name: "Roofing", category: home_services)
SubCategory.create(name: "Windows", category: home_services)

health_inspection = CategoryOption.create(name: "Health Inspection", options: ["A", "B", "C", "D"], searchable: false, category: restaurants)
reservations = CategoryOption.create(name: "Takes Reservations", options: ["Yes", "No"], searchable: true, category: restaurants)
delivery = CategoryOption.create(name: "Delivery", options: ["Yes", "No"], searchable: true, category: restaurants)
takeout = CategoryOption.create(name: "Take Out", options: ["Yes", "No"], searchable: true, category: restaurants)
CategoryOption.create(name: "Accepts Credit Cards", options: ["Yes", "No"], searchable: false, category: restaurants)
CategoryOption.create(name: "Good For Kids", options: ["Yes", "No"], searchable: false, category: restaurants)
CategoryOption.create(name: "Good For Groups", options: ["Yes", "No"], searchable: false, category: restaurants)
CategoryOption.create(name: "Alcohol", options: ["Yes", "No"], searchable: false, category: restaurants)
CategoryOption.create(name: "Outdoor Seating", options: ["Yes", "No"], searchable: false, category: restaurants)
CategoryOption.create(name: "Wi-fi", options: ["Yes", "No"], searchable: false, category: restaurants)
CategoryOption.create(name: "Dogs Allowed", options: ["Yes", "No"], searchable: false, category: restaurants)
CategoryOption.create(name: "Waiter Service", options: ["Yes", "No"], searchable: false, category: restaurants)
CategoryOption.create(name: "Caters", options: ["Yes", "No"], searchable: false, category: restaurants)
CategoryOption.create(name: "Good For", options: ["Breakfast", "Lunch", "Dinner", "Anytime"], searchable: false, category: restaurants)
parking = CategoryOption.create(name: "Parking", options: ["Lot", "Street", "Garage", "Valet"], searchable: false, category: restaurants)
attire = CategoryOption.create(name: "Attire", options: ["Casual", "Semi-formal", "Formal"], searchable: false, category: restaurants)
ambience = CategoryOption.create(name: "Ambience", options: ["Romantic", "Hipster", "Trendy", "Intimate", "Dive-y", "Casual", "Classy"], searchable: false, category: restaurants)
CategoryOption.create(name: "Noise Level", options: ["Average", "Quiet", "Loud"], searchable: false, category: restaurants)

online_booking = CategoryOption.create(name: "Online Booking", options: ["Yes", "No"], searchable: true, category: nightlife)
cash_back = CategoryOption.create(name: "Cash Back", options: ["Yes", "No"], searchable: true, category: nightlife)
dj = CategoryOption.create(name: "Music: DJ", options: ["Yes", "No"], searchable: true, category: nightlife)
live_music = CategoryOption.create(name: "Music: Live", options: ["Yes", "No"], searchable: false, category: nightlife)
CategoryOption.create(name: "Takes Reservations", options: ["Yes", "No"], searchable: false, category: nightlife)
CategoryOption.create(name: "Accepts Credit Cards", options: ["Yes", "No"], searchable: false, category: nightlife)
CategoryOption.create(name: "Parking", options: ["Lot", "Street", "Garage", "Valet"], searchable: false, category: nightlife)
CategoryOption.create(name: "Good For Kids", options: ["Yes", "No"], searchable: false, category: nightlife)
CategoryOption.create(name: "Good For Groups", options: ["Yes", "No"], searchable: false, category: nightlife)
CategoryOption.create(name: "Good For Dancing", options: ["Yes", "No"], searchable: false, category: nightlife)
CategoryOption.create(name: "Ambience", options: ["Romantic", "Hipster", "Trendy", "Intimate", "Dive-y", "Casual", "Classy"], searchable: false, category: nightlife)
CategoryOption.create(name: "Noise Level", options: ["Average", "Quiet", "Loud"], searchable: false, category: nightlife)
CategoryOption.create(name: "Alcohol", options: ["Beer & Wine", "Full Bar", "None"], searchable: false, category: nightlife)
CategoryOption.create(name: "Happy Hour", options: ["Yes", "No"], searchable: false, category: nightlife)
CategoryOption.create(name: "Coat Check", options: ["Yes", "No"], searchable: false, category: nightlife)
CategoryOption.create(name: "Outdoor Seating", options: ["Yes", "No"], searchable: false, category: nightlife)
CategoryOption.create(name: "Has TV", options: ["Yes", "No"], searchable: false, category: nightlife)
CategoryOption.create(name: "Has Pool Table", options: ["Yes", "No"], searchable: false, category: nightlife)

request_quote = CategoryOption.create(name: "Request A Quote", options: ["Yes", "No"], searchable: true, category: home_services)
credit_cards = CategoryOption.create(name: "Accepts Credit Cards", options: ["Yes", "No"], searchable: false, category: home_services)
appointment = CategoryOption.create(name: "By Appointment Only", options: ["Yes", "No"], searchable: false, category: home_services)

ryan = User.new(name: "Ryan", email: "ry.gil.online@gmail.com", password: "password", city: la, tagline: "Check out my awesome Yelp clone!", gender: "Male", i_love: "Reviewing stuff!!", hometown: "New Haven, CT", website: "www.yelp.com", when_im_not_reviewing: "I'm doing other stuff")
ryan.avatar = Rails.root.join("db/images/ryan1.jpg").open
ryan.save!

john = User.create(name: "John Doe", email: "john@example.com", password: "password", city: la, tagline: "Who am I?", gender: "Male", i_love: "Being anonymous!", hometown: "Anytown, USA")

susie = User.new(name: "Susie Q", email: "sq@example.com", password: "password", city: seattle, tagline: "Where are you?", gender: "Female", i_love: "CCR", hometown: "El Cerrito, CA")
susie.avatar = Rails.root.join("db/images/susieq.jpg").open
susie.save!

maryjane = User.new(name: "Mary Jane", email: "mj@example.com", password: "password", city: portland, tagline: "Hey Tiger", gender: "Female", hometown: "Queens, NY")
maryjane.avatar = Rails.root.join("db/images/maryjane.jpg").open
maryjane.save!

samus = User.new(name: "Samus Aran", email: "samus@zebes.gov", password: "password", city: san_fran, tagline: "...", gender: "Female", hometown: "Earth Colony K-2L")
samus.avatar = Rails.root.join("db/images/samus.jpg").open
samus.save!

proto = User.new(name: "Proto Man", email: "proto@the_man.com", password: "password", city: seattle, tagline: "Check out my blog!", gender: "Male", hometown: "Mega City", website: "proto-blog.herokuapp.com")
proto.avatar = Rails.root.join("db/images/proto.jpg").open
proto.save!

beric = User.new(name: "Beric D.", email: "beric@no_banners.com", password: "password", city: seattle, tagline: "Foodie 4 life", gender: "Male", hometown: "Blackhaven")
beric.avatar = Rails.root.join("db/images/beric.jpg").open
beric.save!

Follow.create(user_id: ryan.id, following_id: john.id)
Follow.create(user_id: ryan.id, following_id: susie.id)
Follow.create(user_id: ryan.id, following_id: maryjane.id)
Follow.create(user_id: ryan.id, following_id: samus.id)
Follow.create(user_id: ryan.id, following_id: proto.id)
Follow.create(user_id: susie.id, following_id: john.id)
Follow.create(user_id: susie.id, following_id: maryjane.id)
Follow.create(user_id: susie.id, following_id: samus.id)
Follow.create(user_id: susie.id, following_id: proto.id)
Follow.create(user_id: john.id, following_id: maryjane.id)
Follow.create(user_id: samus.id, following_id: john.id)
Follow.create(user_id: samus.id, following_id: maryjane.id)
Follow.create(user_id: samus.id, following_id: susie.id)
Follow.create(user_id: samus.id, following_id: ryan.id)
Follow.create(user_id: samus.id, following_id: proto.id)
Follow.create(user_id: beric.id, following_id: susie.id)
Follow.create(user_id: beric.id, following_id: ryan.id)
Follow.create(user_id: beric.id, following_id: proto.id)

Friendship.create(user_id: ryan.id, friend_id: john.id)
Friendship.create(user_id: ryan.id, friend_id: susie.id)
Friendship.create(user_id: ryan.id, friend_id: maryjane.id)
Friendship.create(user_id: ryan.id, friend_id: samus.id)
Friendship.create(user_id: ryan.id, friend_id: proto.id)
Friendship.create(user_id: maryjane.id, friend_id: susie.id)
Friendship.create(user_id: maryjane.id, friend_id: john.id)
Friendship.create(user_id: maryjane.id, friend_id: samus.id)
Friendship.create(user_id: john.id, friend_id: susie.id)
Friendship.create(user_id: john.id, friend_id: samus.id)
Friendship.create(user_id: john.id, friend_id: proto.id)
Friendship.create(user_id: beric.id, friend_id: maryjane.id)
Friendship.create(user_id: beric.id, friend_id: samus.id)
Friendship.create(user_id: beric.id, friend_id: proto.id)
Friendship.create(user_id: beric.id, friend_id: ryan.id)

conversation = Conversation.create(title: "Hi Susie", sender: ryan, recipient: susie, sender_trash: false, recipient_trash: false)
Message.create(body: "Hi susie, what's up?", user: ryan, conversation: conversation, unread: false)
Message.create(body: "Nothing much", user: susie, conversation: conversation, unread: true)

fatburger = Business.create(name: "Fatburger", address: "11275 Venice Blvd", zip_code: "90066", price_range: "$", phone_number: "5556667777", city: la, owner: ryan)
in_n_out = Business.create(name: "In N Out Burger", address: "7009 Sunset Blvd", zip_code: "90028", price_range: "$", phone_number: "1234567890", city: la, owner: proto)
seattle_seafood = Business.create(name: "Blueacre Seafood", address: "1700 7th Ave", zip_code: "98101", price_range: "$$$", phone_number: "9998887766", city: seattle, owner: susie)
smell = Business.create(name: "The Smell", address: "247 S. Main St.", zip_code: "90012", price_range: "$", phone_number: "1112223333", city: la, owner: samus)
red_lion = Business.create(name: "The Red Lion", address: "2366 Glendale Blvd", zip_code: "90039", price_range: "$$", phone_number: "3236625337", city: la, owner: ryan)
soundgarden = Business.create(name: "The SoundGarden", address: "7600 Sand Point Way NE", zip_code: "98115", price_range: "$$", phone_number: "3334445555", city: seattle, owner: susie)
pike = Business.create(name: "Pike Place Chowder", address: "1530 Post Alley", zip_code: "98101", price_range: "$", phone_number: "2062672537", city: seattle, owner: susie)
portland_home = Business.create(name: "Portland Home Repair", address: "99 Portlandia Dr", zip_code: "55555", price_range: "$$", phone_number: "5554443333", city: portland, owner: maryjane)
vegan_bar = Business.create(name: "Hipster Bar", address: "736 SE Grand Ave", zip_code: "97214", price_range: "$$", phone_number: "1112223333", city: portland, owner: maryjane)
voodoo = Business.create(name: "Voodoo Doughnut", address: "22 SW 3rd Ave", zip_code: "97204", price_range: "$$", phone_number: "5032414704", city: portland, owner: maryjane)
plumbers_store = Business.create(name: "Plumbers R Us", address: "288 Sepulveda Blvd", zip_code: "90066", price_range: "$$$", phone_number: "7776667777", city: la, owner: ryan)

Hour.create(business: fatburger, day: "1", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 18:00:00")
Hour.create(business: fatburger, day: "2", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 18:00:00")
Hour.create(business: fatburger, day: "3", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 18:00:00")
Hour.create(business: fatburger, day: "4", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 18:00:00")
Hour.create(business: fatburger, day: "5", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 18:00:00")
Hour.create(business: fatburger, day: "6", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 18:00:00")

Hour.create(business: in_n_out, day: "1", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 18:00:00")
Hour.create(business: in_n_out, day: "2", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 18:00:00")
Hour.create(business: in_n_out, day: "3", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 18:00:00")
Hour.create(business: in_n_out, day: "4", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 18:00:00")
Hour.create(business: in_n_out, day: "5", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 18:00:00")
Hour.create(business: in_n_out, day: "6", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 18:00:00")

Hour.create(business: pike, day: "1", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 18:00:00")
Hour.create(business: pike, day: "2", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 18:00:00")
Hour.create(business: pike, day: "3", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 18:00:00")
Hour.create(business: pike, day: "4", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 18:00:00")
Hour.create(business: pike, day: "5", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 18:00:00")
Hour.create(business: pike, day: "6", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 18:00:00")

Hour.create(business: seattle_seafood, day: "2", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 20:00:00")
Hour.create(business: seattle_seafood, day: "3", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 20:00:00")
Hour.create(business: seattle_seafood, day: "4", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 20:00:00")

Hour.create(business: voodoo, day: "4", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 20:00:00")
Hour.create(business: voodoo, day: "5", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 20:00:00")
Hour.create(business: voodoo, day: "6", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 20:00:00")
Hour.create(business: voodoo, day: "7", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 20:00:00")

Hour.create(business: red_lion, day: "5", opens_at: "2000-01-01 15:00:00", closes_at: "2000-01-01 23:00:00")
Hour.create(business: red_lion, day: "6", opens_at: "2000-01-01 15:00:00", closes_at: "2000-01-01 23:00:00")
Hour.create(business: red_lion, day: "7", opens_at: "2000-01-01 15:00:00", closes_at: "2000-01-01 23:00:00")

Hour.create(business: smell, day: "5", opens_at: "2000-01-01 15:00:00", closes_at: "2000-01-01 23:00:00")
Hour.create(business: smell, day: "6", opens_at: "2000-01-01 15:00:00", closes_at: "2000-01-01 23:00:00")
Hour.create(business: smell, day: "7", opens_at: "2000-01-01 15:00:00", closes_at: "2000-01-01 23:00:00")

Hour.create(business: soundgarden, day: "5", opens_at: "2000-01-01 16:00:00", closes_at: "2000-01-01 23:00:00")
Hour.create(business: soundgarden, day: "6", opens_at: "2000-01-01 16:00:00", closes_at: "2000-01-01 23:00:00")

Hour.create(business: portland_home, day: "1", opens_at: "2000-01-01 06:00:00", closes_at: "2000-01-01 15:00:00")

Hour.create(business: vegan_bar, day: "2", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 21:00:00")
Hour.create(business: vegan_bar, day: "3", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 21:00:00")
Hour.create(business: vegan_bar, day: "4", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 21:00:00")
Hour.create(business: vegan_bar, day: "5", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 21:00:00")
Hour.create(business: vegan_bar, day: "6", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 21:00:00")
Hour.create(business: vegan_bar, day: "7", opens_at: "2000-01-01 09:00:00", closes_at: "2000-01-01 22:00:00")

Hour.create(business: plumbers_store, day: "2", opens_at: "2000-01-01 08:00:00", closes_at: "2000-01-01 17:00:00")
Hour.create(business: plumbers_store, day: "3", opens_at: "2000-01-01 08:00:00", closes_at: "2000-01-01 17:00:00")
Hour.create(business: plumbers_store, day: "4", opens_at: "2000-01-01 08:00:00", closes_at: "2000-01-01 17:00:00")

event_1 = Event.create(start_time: "2017-03-27 05:39:25.149617", price: "$10.00", business: fatburger, name: "Burger Fest 1", description: "Some burgers, beers, a few laughs...")
event_2 = Event.create(start_time: "2018-03-27 05:39:25.149617", price: "$10.00", business: fatburger, name: "Burger Fest 2", description: "Some burgers, beers, a few laughs...")
event_3 = Event.create(start_time: "2018-02-15 05:39:25.149617", price: "$25.00", business: soundgarden, name: "Screaming Life", description: "Serious riffage from your favorite Seattle bands!")
event_4 = Event.create(start_time: "2018-01-03 18:30:25.149617", price: "$5.00", business: smell, name: "Local Hipsters Make Noise", description: "Totally cool noise, bro.")

UserEvent.create(user: ryan, event: event_1)
UserEvent.create(user: ryan, event: event_2)
UserEvent.create(user: ryan, event: event_3)
UserEvent.create(user: john, event: event_2)
UserEvent.create(user: john, event: event_3)
UserEvent.create(user: john, event: event_4)
UserEvent.create(user: maryjane, event: event_1)
UserEvent.create(user: samus, event: event_2)
UserEvent.create(user: samus, event: event_3)
UserEvent.create(user: susie, event: event_1)
UserEvent.create(user: susie, event: event_4)
UserEvent.create(user: proto, event: event_2)
UserEvent.create(user: proto, event: event_1)

Review.create(body: "Great burgers here!", star_rating: 5, user: ryan, business: fatburger)
review_2 = Review.create(body: "I ate the biggest burger! Wow, so full!", star_rating: 5, user: proto, business: fatburger)
Review.create(body: "Pretty good burgers here!", star_rating: 4, user: ryan, business: in_n_out)
review_1 = Review.create(body: "Good atmosphere and beer. 4 stars!", star_rating: 4, user: ryan, business: red_lion)
Review.create(body: "This place is pretty good, I guess.", star_rating: 4, user: john, business: red_lion)
Review.create(body: "Kinda smells here", star_rating: 4, user: proto, business: smell)
Review.create(body: "No beer?! Come on, dudes!", star_rating: 3, user: susie, business: smell)
Review.create(body: "I'm reviewing!!! OMG!", star_rating: 4, user: john, business: vegan_bar)
Review.create(body: "Best seafood ever!!!", star_rating: 5, user: susie, business: seattle_seafood)
review_3 = Review.create(body: "Best seafood ever!!! Part 2!", star_rating: 5, user: susie, business: seattle_seafood)
Review.create(body: "Good drinks and riffs!", star_rating: 5, user: susie, business: soundgarden)
Review.create(body: "Two many donuts! I can't choose!", star_rating: 4, user: beric, business: voodoo)
Review.create(body: "Too many hipsters here, but the drinks are cheap. Two stars.", star_rating: 2, user: maryjane, business: vegan_bar)
Review.create(body: "Music is too loud here.", star_rating: 3, user: maryjane, business: soundgarden)
review_6 = Review.create(body: "Terrible business. One star.", star_rating: 1, user: maryjane, business: portland_home)
Review.create(body: "Came for the beer, stayed for the riffs. 4 stars.", star_rating: 4, user: beric, business: soundgarden)
Review.create(body: "Get the animal style burger!", star_rating: 5, user: john, business: in_n_out)
review_4 = Review.create(body: "I've got nothing to say", star_rating: 5, user: samus, business: soundgarden)
Review.create(body: "OMG! So good!", star_rating: 4, user: maryjane, business: voodoo)
review_5 = Review.create(body: "It's chowdah! Say it right!", star_rating: 4, user: proto, business: pike)


ReviewStat.create(useful: true, cool: true, user: ryan, review: review_1)
ReviewStat.create(useful: true, user: john, review: review_1)
ReviewStat.create(funny: true, user: john, review: review_2)
ReviewStat.create(useful: true, funny: true, user: ryan, review: review_3)
ReviewStat.create(useful: true, funny: true, cool: true, user: john, review: review_3)
ReviewStat.create(useful: true, funny: true, cool: true, user: john, review: review_4)
ReviewStat.create(useful: true, cool: true, user: proto, review: review_4)
ReviewStat.create(funny: true, cool: true, user: beric, review: review_5)
ReviewStat.create(useful: true, funny: true, user: samus, review: review_5)
ReviewStat.create(useful: true, user: samus, review: review_6)

BusinessSubCategory.create(business: fatburger, sub_category: burgers)
BusinessSubCategory.create(business: fatburger, sub_category: fast_food)
BusinessSubCategory.create(business: in_n_out, sub_category: burgers)
BusinessSubCategory.create(business: in_n_out, sub_category: fast_food)
BusinessSubCategory.create(business: seattle_seafood, sub_category: seafood)
BusinessSubCategory.create(business: pike, sub_category: seafood)
BusinessSubCategory.create(business: voodoo, sub_category: fast_food)
BusinessSubCategory.create(business: red_lion, sub_category: bars)
BusinessSubCategory.create(business: soundgarden, sub_category: bars)
BusinessSubCategory.create(business: soundgarden, sub_category: music_venues)
BusinessSubCategory.create(business: smell, sub_category: bars)
BusinessSubCategory.create(business: smell, sub_category: music_venues)
BusinessSubCategory.create(business: portland_home, sub_category: contractors)
BusinessSubCategory.create(business: portland_home, sub_category: heating)
BusinessSubCategory.create(business: vegan_bar, sub_category: piano_bars)
BusinessSubCategory.create(business: vegan_bar, sub_category: bars)
BusinessSubCategory.create(business: plumbers_store, sub_category: plumbing)

BusinessOption.create(option: "B", business: fatburger, category_option: health_inspection)
BusinessOption.create(option: "No", business: fatburger, category_option: reservations)
BusinessOption.create(option: "Yes", business: fatburger, category_option: delivery)
BusinessOption.create(option: "Yes", business: fatburger, category_option: takeout)
BusinessOption.create(option: "Lot", business: fatburger, category_option: parking)
BusinessOption.create(option: "Casual", business: fatburger, category_option: attire)
BusinessOption.create(option: "Casual", business: fatburger, category_option: ambience)

BusinessOption.create(option: "A", business: in_n_out, category_option: health_inspection)
BusinessOption.create(option: "No", business: in_n_out, category_option: reservations)
BusinessOption.create(option: "No", business: in_n_out, category_option: delivery)
BusinessOption.create(option: "Yes", business: in_n_out, category_option: takeout)
BusinessOption.create(option: "Street", business: in_n_out, category_option: parking)
BusinessOption.create(option: "Casual", business: in_n_out, category_option: attire)
BusinessOption.create(option: "Casual", business: in_n_out, category_option: ambience)

BusinessOption.create(option: "A", business: seattle_seafood, category_option: health_inspection)
BusinessOption.create(option: "Yes", business: seattle_seafood, category_option: reservations)
BusinessOption.create(option: "Yes", business: seattle_seafood, category_option: delivery)
BusinessOption.create(option: "Yes", business: seattle_seafood, category_option: takeout)
BusinessOption.create(option: "Valet", business: seattle_seafood, category_option: parking)
BusinessOption.create(option: "Formal", business: seattle_seafood, category_option: attire)
BusinessOption.create(option: "Trendy", business: seattle_seafood, category_option: ambience)

BusinessOption.create(option: "No", business: red_lion, category_option: online_booking)
BusinessOption.create(option: "Yes", business: red_lion, category_option: cash_back)
BusinessOption.create(option: "No", business: red_lion, category_option: dj)
BusinessOption.create(option: "No", business: red_lion, category_option: live_music)

BusinessOption.create(option: "Yes", business: soundgarden, category_option: online_booking)
BusinessOption.create(option: "No", business: soundgarden, category_option: cash_back)
BusinessOption.create(option: "No", business: soundgarden, category_option: dj)
BusinessOption.create(option: "Yes", business: soundgarden, category_option: live_music)

BusinessOption.create(option: "No", business: smell, category_option: online_booking)
BusinessOption.create(option: "No", business: smell, category_option: cash_back)
BusinessOption.create(option: "No", business: smell, category_option: dj)
BusinessOption.create(option: "Yes", business: smell, category_option: live_music)

BusinessOption.create(option: "Yes", business: vegan_bar, category_option: online_booking)
BusinessOption.create(option: "Yes", business: vegan_bar, category_option: cash_back)
BusinessOption.create(option: "Yes", business: vegan_bar, category_option: dj)
BusinessOption.create(option: "No", business: vegan_bar, category_option: live_music)

BusinessOption.create(option: "Yes", business: portland_home, category_option: request_quote)
BusinessOption.create(option: "No", business: portland_home, category_option: credit_cards)
BusinessOption.create(option: "Yes", business: portland_home, category_option: appointment)

BusinessOption.create(option: "No", business: plumbers_store, category_option: request_quote)
BusinessOption.create(option: "Yes", business: plumbers_store, category_option: credit_cards)
BusinessOption.create(option: "No", business: plumbers_store, category_option: appointment)

Bookmark.create(user: ryan, business: fatburger)
Bookmark.create(user: ryan, business: in_n_out)
Bookmark.create(user: ryan, business: red_lion)
Bookmark.create(user: ryan, business: soundgarden)

Bookmark.create(user: john, business: fatburger)
Bookmark.create(user: john, business: in_n_out)
Bookmark.create(user: john, business: smell)

Bookmark.create(user: susie, business: seattle_seafood)
Bookmark.create(user: susie, business: soundgarden)

Bookmark.create(user: samus, business: seattle_seafood)
Bookmark.create(user: samus, business: soundgarden)

Bookmark.create(user: maryjane, business: fatburger)
Bookmark.create(user: maryjane, business: portland_home)
Bookmark.create(user: maryjane, business: vegan_bar)

Bookmark.create(user: proto, business: smell)

topic_1 = TopicCategory.create(name: "Local Questions & Answers")
topic_2 = TopicCategory.create(name: "Events")
topic_3 = TopicCategory.create(name: "Food")
topic_4 = TopicCategory.create(name: "Travel")
TopicCategory.create(name: "Relationships & Dating")
TopicCategory.create(name: "Entertainment")
topic_5 = TopicCategory.create(name: "Sports")
TopicCategory.create(name: "News & Politics")

forum_1 = Topic.create(title: "No parking in LA!", topic_category: topic_1, city: la, user: ryan)
Post.create(body: "What's up with that?", user: ryan, topic: forum_1)
Post.create(body: "too many cars, bro", user: john, topic: forum_1)

forum_2 = Topic.create(title: "Echo Park too trendy?", topic_category: topic_1, city: la, user: john)
Post.create(body: "Thoughts?", user: john, topic: forum_2)
Post.create(body: "def", user: ryan, topic: forum_2)
Post.create(body: "Totally disagree.", user: maryjane, topic: forum_2)

forum_3 = Topic.create(title: "Who's going to Burger Fest?", topic_category: topic_2, city: la, user: proto)
Post.create(body: "?", user: proto, topic: forum_3)
Post.create(body: "Me", user: john, topic: forum_3)
Post.create(body: "Def", user: ryan, topic: forum_3)

forum_4 = Topic.create(title: "LA pizza is overrated. Thoughts?", topic_category: topic_3, city: la, user: samus)
Post.create(body: "...", user: samus, topic: forum_4)
Post.create(body: "New Haven is better", user: ryan, topic: forum_4)

forum_5 = Topic.create(title: "Best LA burger...", topic_category: topic_3, city: la, user: john)
Post.create(body: "Umami, Father's Office, etc...", user: john, topic: forum_5)

forum_6 = Topic.create(title: "LAX, wtf?", topic_category: topic_4, city: la, user: john)
Post.create(body: "Lorem ipsum, etc.", user: john, topic: forum_6)

forum_7 = Topic.create(title: "Chargers & Rams?!?! Shoulda been Raiders.", topic_category: topic_5, city: la, user: proto)
Post.create(body: "Ice Cube agrees", user: proto, topic: forum_7)

forum_8 = Topic.create(title: "SF post!", topic_category: topic_1, city: san_fran, user: samus)
Post.create(body: "Lorem ipsum, etc...", user: samus, topic: forum_8)
Post.create(body: "So true!", user: john, topic: forum_8)

forum_9 = Topic.create(title: "Have you ever seen the rain?", topic_category: topic_1, city: seattle, user: susie)
Post.create(body: "In Seattle?", user: susie, topic: forum_9)
Post.create(body: "totes", user: samus, topic: forum_9)

forum_10 = Topic.create(title: "Vegetarian or vegan?", topic_category: topic_3, city: seattle, user: susie)
Post.create(body: "Vegan!", user: susie, topic: forum_10)
Post.create(body: "Vegetarian!", user: maryjane, topic: forum_10)

forum_11 = Topic.create(title: "Hurray, local sports team!", topic_category: topic_5, city: seattle, user: maryjane)
Post.create(body: "Hurray!!!", user: maryjane, topic: forum_11)
Post.create(body: "shut up ur stupid", user: samus, topic: forum_11)

forum_12 = Topic.create(title: "Voodoo Doughnut, OMG!", topic_category: topic_3, city: portland, user: maryjane)
Post.create(body: "!!!", user: maryjane, topic: forum_12)
Post.create(body: "!!!!", user: susie, topic: forum_12)
Post.create(body: "!!!!!", user: ryan, topic: forum_12)
Post.create(body: "!!!!!!", user: samus, topic: forum_12)

forum_13 = Topic.create(title: "Local news is so local...", topic_category: topic_1, city: portland, user: maryjane)
Post.create(body: "Lorem ipsum, etc...", user: maryjane, topic: forum_13)

pic1 = BusinessPic.new(business: fatburger, user: ryan)
pic1.image = Rails.root.join("db/images/fatburger1.jpg").open
pic1.save!

pic2 = BusinessPic.new(business: fatburger, user: john)
pic2.image = Rails.root.join("db/images/fatburger2.jpg").open
pic2.save!

pic3 = BusinessPic.new(business: fatburger, user: ryan)
pic3.image = Rails.root.join("db/images/fatburger3.jpg").open
pic3.save!

pic4 = BusinessPic.new(business: fatburger, user: susie)
pic4.image = Rails.root.join("db/images/fatburger6.jpg").open
pic4.save!

pic5 = BusinessPic.new(business: fatburger, user: susie)
pic5.image = Rails.root.join("db/images/fatburger5.jpg").open
pic5.save!

pic6 = BusinessPic.new(business: fatburger, user: proto)
pic6.image = Rails.root.join("db/images/fatburger4.jpg").open
pic6.save!

pic7 = BusinessPic.new(business: seattle_seafood, user: susie)
pic7.image = Rails.root.join("db/images/seattle.jpg").open
pic7.save!

pic8 = BusinessPic.new(business: in_n_out, user: ryan)
pic8.image = Rails.root.join("db/images/innout1.jpg").open
pic8.save!

pic9 = BusinessPic.new(business: in_n_out, user: john)
pic9.image = Rails.root.join("db/images/innout2.jpg").open
pic9.save!

pic10 = BusinessPic.new(business: red_lion, user: john)
pic10.image = Rails.root.join("db/images/redlion1.jpg").open
pic10.save!

pic11 = BusinessPic.new(business: red_lion, user: ryan)
pic11.image = Rails.root.join("db/images/redlion2.jpg").open
pic11.save!

pic12 = BusinessPic.new(business: red_lion, user: samus)
pic12.image = Rails.root.join("db/images/redlion3.jpg").open
pic12.save!

pic13 = BusinessPic.new(business: soundgarden, user: ryan)
pic13.image = Rails.root.join("db/images/soundgarden.jpg").open
pic13.save!

pic14 = BusinessPic.new(business: portland_home, user: maryjane)
pic14.image = Rails.root.join("db/images/hardware.jpg").open
pic14.save!

pic15 = BusinessPic.new(business: smell, user: proto)
pic15.image = Rails.root.join("db/images/smell1.jpg").open
pic15.save!

pic16 = BusinessPic.new(business: smell, user: ryan)
pic16.image = Rails.root.join("db/images/smell2.jpg").open
pic16.save!

pic17 = BusinessPic.new(business: smell, user: maryjane)
pic17.image = Rails.root.join("db/images/smell3.jpg").open
pic17.save!

pic18 = BusinessPic.new(business: pike, user: beric)
pic18.image = Rails.root.join("db/images/pike1.jpg").open
pic18.save!

pic19 = BusinessPic.new(business: pike, user: beric)
pic19.image = Rails.root.join("db/images/pike2.jpg").open
pic19.save!

pic20 = BusinessPic.new(business: pike, user: maryjane)
pic20.image = Rails.root.join("db/images/pike3.jpg").open
pic20.save!

pic21 = BusinessPic.new(business: voodoo, user: susie)
pic21.image = Rails.root.join("db/images/voodoo1.jpg").open
pic21.save!

pic22 = BusinessPic.new(business: voodoo, user: ryan)
pic22.image = Rails.root.join("db/images/voodoo2.jpg").open
pic22.save!
