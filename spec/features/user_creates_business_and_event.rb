require "spec_helper"

feature "user creates business and event" do
  scenario "user creates business" do
    ca = Fabricate(:state)
    la = Fabricate(:city, state: ca)
    alice = Fabricate(:user, city: la)
    restaurants = Fabricate(:category)
    burgers = Fabricate(:sub_category, category: restaurants)
    delivery = CategoryOption.create(category: restaurants, name: "Delivery", options: ["Yes", "No"], searchable: true)
    takeout = CategoryOption.create(category: restaurants, name: "Takeout", options: ["Yes", "No"], searchable: true)

    sign_in(alice)
    visit new_city_business_path(la)
    fill_in "Business Name", with: "Fatburger"
    fill_in "Phone Number", with: "5556667777"
    fill_in "Address", with: "123 Main St"
    fill_in "Zip Code", with: "12345"
    find("select#business_city_id").find("option[value='1']").select_option
    find("select#business_sub_category_ids").find("option[value='1']").select_option
    find("select#business_price_range").find("option[value='$']").select_option
    find("input[type='submit']").click
    page.should have_content "Your business page was created!"

    find("select#business_business_options_attributes_0_option").find("option[value='Yes']").select_option
    find("select#business_business_options_attributes_1_option").find("option[value='No']").select_option
    find("input[type='submit']").click
    page.should have_content "Fatburger"
    page.should have_content "123 Main St"
    page.should have_content "Recommended Reviews"

    click_link "Events archive"
    page.should have_content "Fatburger doesn't have any upcoming events"

    click_link "Create Event"
    page.should have_content "Create A New Event"

    fill_in "Event Name", with: "Burger Fest"
    fill_in "Price", with: "$10"
    fill_in "Describe the event here!", with: "Eat some burgers!"
    find("select#event_start_time_1i").find("option[value='2020']").select_option
    find("select#event_start_time_2i").find("option[value='1']").select_option
    find("select#event_start_time_3i").find("option[value='1']").select_option
    find("select#event_start_time_4i").find("option[value='00']").select_option
    find("select#event_start_time_5i").find("option[value='00']").select_option
    find("input[type='submit']").click
    page.should have_content "Your event has been created!"
    page.should have_content "Burger Fest"

    click_link "Burger Fest"
    page.should have_content "@ Fatburger"
    page.should have_content "Event Description"

    click_link "Attend This Event"
    visit user_path(alice)
    find(".user-left-sidebar a.user-sidebar-tab-events").click
    page.should have_content "Burger Fest"

    visit city_events_path(la)
    page.should have_content "Burger Fest"

    visit root_path
    page.should have_content "Fatburger"

    visit category_path(restaurants)
    page.should have_content "Fatburger"

    click_link "Delivery"
    page.should have_content "Fatburger"

    click_link "Takeout"
    page.should have_content "There are no businesses in this category."

    visit category_sub_category_path(restaurants, burgers)
    page.should have_content "Fatburger"

    click_link "Delivery"
    page.should have_content "Fatburger"

    click_link "Takeout"
    page.should have_content "There are no businesses in this category."
  end
end
