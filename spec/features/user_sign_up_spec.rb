require "spec_helper"

feature "user signs up" do
  let(:ca) { Fabricate(:state) }

  scenario "with valid info" do
    Fabricate(:city, state: ca)
    visit signup_path
    fill_in "Name", with: "John Doe"
    fill_in "Email", with: "email@email.com"
    fill_in "Password", with: "password"
    find("select#user_city_id").find("option[value='1']").select_option
    find("input[type='submit']").click
    page.should have_content "You are now registered"
  end

  scenario "with invalid info" do
    visit signup_path
    find("input[type='submit']").click
    page.should have_content "Name can't be blank"
  end
end
