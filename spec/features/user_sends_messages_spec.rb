require "spec_helper"

feature "user sends and receives messages" do
  scenario "user sends message" do
    ca = Fabricate(:state)
    la = Fabricate(:city, state: ca)
    alice = Fabricate(:user, city: la)
    bob = Fabricate(:user, city: la)
    Friendship.create(user: alice, friend: bob)

    sign_in(alice)
    visit conversations_path
    page.should have_content "Messages"

    click_link "Write New Message"
    page.should have_content "Cancel"

    find("select#conversation_recipient_id").find("option[value='2']").select_option
    fill_in "Subject", with: "Hi Bob"
    fill_in "Message", with: "What's up?"
    find("input[type='submit']").click

    sign_out
    sign_in(bob)
    visit conversations_path
    page.should have_content alice.name
    page.should have_content "Hi Bob"

    click_link "Hi Bob"
    page.should have_content "What's up?"
    page.should have_content "Back to your inbox"

    fill_in "Reply", with: "some reply"
    find("input[type='submit']").click
    page.should have_content "Your message was sent!"
    page.should have_content "some reply"
    page.should have_content bob.name

    sign_out
    sign_in(alice)
    visit conversations_path
    page.should have_content bob.name
    page.should have_content "Hi Bob"

    click_link "Hi Bob"
    page.should have_content "some reply"

    click_link "Back to your inbox"
    page.should have_content "Check all"

    first(".conversation-check").set(true)
    find(".delete-conversation-submit-top input[type='submit']").click

    page.should have_content "Want to communicate on a more personal level with your friends?"

    click_link "Trash"
    page.should have_content "Hi Bob"

    first(".conversation-check").set(true)
    find(".delete-conversation-submit-top input[type='submit']").click
    click_link "Trash"
    page.should have_content "Your trash is empty"
  end
end
