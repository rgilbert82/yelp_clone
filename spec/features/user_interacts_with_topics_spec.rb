require "spec_helper"

feature "user interacts with topics forum" do
  scenario "user creates a new topic" do
    ca = Fabricate(:state)
    la = Fabricate(:city, state: ca)
    sports = Fabricate(:topic_category)
    alice = Fabricate(:user, city: la)
    sign_in(alice)

    visit city_topics_path(la)
    click_link "New Conversation"

    fill_in "Topic Name", with: "Cool topic name"
    find("select#topic_topic_category_id").find("option[value='1']").select_option
    find("select#topic_city_id").find("option[value='1']").select_option
    fill_in "Message", with: "Cool message"
    find("input[type='submit']").click

    page.should have_content "Cool topic name"
    page.should have_content sports.name
    page.should have_content alice.name
    page.should have_content "Cool message"

    fill_in "Enter Your Reply", with: "New reply!!!"
    find("input[type='submit']").click

    page.should have_content "Thanks for posting!"
    page.should have_content "New reply!!!"
  end
end
