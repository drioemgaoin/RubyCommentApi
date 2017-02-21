class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]

  swagger_controller :comments, 'Comments'

  swagger_api :index do
    summary 'Returns all comments'
    notes 'The list of all comments'
    response :not_acceptable
  end

  swagger_api :show do
    summary 'Returns the comment'
    notes 'Show the comment'
    param :path, :id, :integer, :required, 'Id of the comment to show'
    response :not_found
    response :not_acceptable
  end

  swagger_api :create do
    summary 'Create the comment'
    notes 'Create a comment'
    param :form, "comment[user_id]", :string, 'Id of the user'
    param :form, "comment[content]", :text, :required, 'Content of the comment'
    param :form, "comment[created_at]", :datatime, :required, 'Creation date of the comment'
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :update do
    summary 'Update the comment'
    notes 'Update a comment'
    param :path, :id, :integer, :required, 'Id of the comment to update'
    param :form, "comment[username]", :string, :optional, 'Username of the comment'
    param :form, "comment[email]", :string, :optional, 'Email of the comment'
    param :form, "comment[content]", :text, :optional, 'Content of the comment'
    response :not_found
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :destroy do
    summary 'Delete the comment'
    notes 'Delete a comment'
    param :path, :id, :integer, :required, 'Id of the comment to delete'
    response :not_found
  end

  # GET /comments
  def index
    comments = Comment.aggregate
    render json: comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      ActionCable.server.broadcast "comment_channel", comment: @comment
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:user_id, :content, :created_at)
    end
end
