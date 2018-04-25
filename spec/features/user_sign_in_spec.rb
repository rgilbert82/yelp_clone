require 'spec_helper'

feature "user signs in" do
  let(:ca) { Fabricate(:state) }
  let(:la) { Fabricate(:city, state: ca) }
  let(:alice) { Fabricate(:user, city: la) }

  scenario "with valid email and password" do
    sign_in(alice)
    page.should have_content "You are signed in!"
  end

  scenario "with invalid email and password" do
    visit login_path
    fill_in "Email", with: "fake@email.com"
    fill_in "Password", with: "password"
    find("input[type='submit']").click
    page.should have_content "Invalid email/password"
  end

  scenario "user signs out" do
    sign_in(alice)
    sign_out
    page.should have_content "You are signed out"
  end
end
