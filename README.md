# Yelp clone

This is a clone of Yelp that I made with Rails 5. Features include:

* Users can register for new accounts.
* Users can make donations to the app. Credit card payments are handled by the [Stripe API](https://stripe.com/) (currently set in test mode).
* Registered users can manage their profiles.
* Registered users can have a password-reset email sent to them if they forget their password.
* Registered users can send messages to other registered users.
* Registered users can befriend other registered users.
* Registered users can follow other registered users.
* Registered users can create topics and post messages on city-specific forums.
* Registered users can create and update new businesses.
* Registered users can write reviews of businesses.
* Registered users can like reviews.
* Businesses are shown on city pages and category pages.
* Businesses can be searched by name, city, or category.
* Businesses can have events.
* Registered users can bookmark businesses and rsvp to events.
* Registered users can upload images of businesses. Image uploads are handled by the [CarrierWave](https://github.com/carrierwaveuploader/carrierwave) gem.
* Admins can manage all user accounts and business pages.


------
[Heroku link](https://rg-yelp-clone.herokuapp.com/)
