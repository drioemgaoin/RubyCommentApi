require 'test_helper'
require 'active_resource/http_mock'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @users = [{
        :avatar => "avatar-url",
        :email => "john.doe@domain.com",
        :first_name => "John",
        :last_name => "Doe"
      }].to_json

    ActiveResource::HttpMock.respond_to do |mock|
      mock.get '/user.json', { "Accept"=>"application/json" }, @users
    end

    @comment = comments(:one)
  end

  test "should get index" do
    get comments_url, as: :json
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post comments_url, params: get_params, as: :json
    end

    assert_response 201
  end

  test "should show comment" do
    get comment_url(@comment), as: :json
    assert_response :success
  end

  test "should update comment" do
    patch comment_url(@comment), params: get_params, as: :json
    assert_response 200
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete comment_url(@comment), as: :json
    end

    assert_response 204
  end

  private

  def get_params
    { comment: { content: @comment.content, created_at: @comment.created_at, username: @comment.username, avatar: @comment.avatar } }
  end
end
