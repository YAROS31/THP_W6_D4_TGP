require "application_system_test_case"

class GossipTagsTest < ApplicationSystemTestCase
  setup do
    @gossip_tag = gossip_tags(:one)
  end

  test "visiting the index" do
    visit gossip_tags_url
    assert_selector "h1", text: "Gossip Tags"
  end

  test "creating a Gossip tag" do
    visit gossip_tags_url
    click_on "New Gossip Tag"

    click_on "Create Gossip tag"

    assert_text "Gossip tag was successfully created"
    click_on "Back"
  end

  test "updating a Gossip tag" do
    visit gossip_tags_url
    click_on "Edit", match: :first

    click_on "Update Gossip tag"

    assert_text "Gossip tag was successfully updated"
    click_on "Back"
  end

  test "destroying a Gossip tag" do
    visit gossip_tags_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Gossip tag was successfully destroyed"
  end
end
