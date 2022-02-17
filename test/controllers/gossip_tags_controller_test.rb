require 'test_helper'

class GossipTagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gossip_tag = gossip_tags(:one)
  end

  test "should get index" do
    get gossip_tags_url
    assert_response :success
  end

  test "should get new" do
    get new_gossip_tag_url
    assert_response :success
  end

  test "should create gossip_tag" do
    assert_difference('GossipTag.count') do
      post gossip_tags_url, params: { gossip_tag: {  } }
    end

    assert_redirected_to gossip_tag_url(GossipTag.last)
  end

  test "should show gossip_tag" do
    get gossip_tag_url(@gossip_tag)
    assert_response :success
  end

  test "should get edit" do
    get edit_gossip_tag_url(@gossip_tag)
    assert_response :success
  end

  test "should update gossip_tag" do
    patch gossip_tag_url(@gossip_tag), params: { gossip_tag: {  } }
    assert_redirected_to gossip_tag_url(@gossip_tag)
  end

  test "should destroy gossip_tag" do
    assert_difference('GossipTag.count', -1) do
      delete gossip_tag_url(@gossip_tag)
    end

    assert_redirected_to gossip_tags_url
  end
end
