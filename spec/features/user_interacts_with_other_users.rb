require "spec_helper"

feature "user interacts with other users" do
  scenario "user makes some friends" do
    ca = Fabricate(:state)
    la = Fabricate(:city, state: ca)
    alice = Fabricate(:user, city: la)
    bob = Fabricate(:user, city: la)
    carl = Fabricate(:user, city: la)

    sign_in(alice)

    visit users_path
    page.should have_content bob.name
    page.should have_content carl.name

    visit user_path(bob)
    page.should have_content bob.name
    click_link "Add friend"
    click_link "Follow #{bob.name}"

    visit user_path(carl)
    page.should have_content carl.name
    click_link "Add friend"
    click_link "Follow #{carl.name}"

    visit user_path(alice)
    page.should have_content "2 Friends"

    find(".user-sidebar-tab-friends").click
    page.should have_content bob.name
    page.should have_content carl.name

    find(".user-sidebar-tab-following").click
    page.should have_content bob.name
    page.should have_content carl.name

    find(".user-sidebar-tab-followers").click
    page.should have_content "You don't have any followers"

    sign_out
    sign_in(bob)
    visit users_path
    page.should have_content alice.name
    page.should have_content carl.name

    visit user_path(bob)
    page.should have_content "1 Friend"

    find(".user-sidebar-tab-friends").click
    page.should have_content alice.name

    find(".user-sidebar-tab-following").click
    page.should have_content "You're not following anyone"

    find(".user-sidebar-tab-followers").click
    page.should have_content alice.name
  end
end
