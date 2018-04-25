require "spec_helper"

feature "user writes a review" do
  scenario "user writes a review" do
    ca = Fabricate(:state)
    la = Fabricate(:city, state: ca)
    alice = Fabricate(:user, city: la)
    bob = Fabricate(:user, city:la)
    restaurants = Fabricate(:category)
    burgers = Fabricate(:sub_category, category: restaurants)
    fatburger = Fabricate(:business, owner: bob, city: la)
    BusinessSubCategory.create(business: fatburger, sub_category: burgers)

    sign_in(alice)
    page.should have_content fatburger.name

    click_link fatburger.name
    page.should have_content fatburger.name

    find(".write-review").click
    page.should have_content "Write A Review"

    first(".star-box").click
    fill_in "Write your review here! Your review helps others learn about great local businesses.", with: "Great burgers!"
    find("input[type='submit']").click
    page.should have_content "Thanks for reviewing!"
    page.should have_content "Great burgers!"

    visit user_path(alice)
    page.should have_content "Great burgers!"

    find(".user-sidebar-tab-reviews").click
    page.should have_content "Great burgers!"
  end
end
