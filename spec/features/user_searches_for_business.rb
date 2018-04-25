require "spec_helper"

feature "user searches" do
  scenario "user searches for burgers" do
    ca = Fabricate(:state)
    la = Fabricate(:city, state: ca)
    sf = Fabricate(:city, state: ca)
    alice = Fabricate(:user, city: la)
    restaurants = Fabricate(:category)
    burgers = Fabricate(:sub_category, category: restaurants)
    fatburger = Fabricate(:business, owner: alice, city: la)
    BusinessSubCategory.create(business: fatburger, sub_category: burgers)

    visit root_path
    fill_in "Find", with: fatburger.name
    find("select#location").find("option[value='1']").select_option
    find(".search-bar-button").click
    page.should have_content "Search results"
    page.should have_content fatburger.name

    fill_in "Find", with: fatburger.name
    find("select#location").find("option[value='2']").select_option
    find(".search-bar-button").click
    page.should have_content "Your search returned no results."

    fill_in "Find", with: fatburger.name + "asdask"
    find("select#location").find("option[value='1']").select_option
    find(".search-bar-button").click
    page.should have_content "Your search returned no results."
  end
end
