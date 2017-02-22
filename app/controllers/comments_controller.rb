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
    param :form, "comment[user_id]", :integer, :optional, 'Id of the user'
    param :form, "comment[content]", :string, :required, 'Content of the comment'
    param :form, "comment[created_at]", :string, :required, 'Creation date of the comment'
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :update do
    summary 'Update the comment'
    notes 'Update a comment'
    param :path, :id, :integer, :required, 'Id of the comment to update'
    param :form, "comment[content]", :string, :optional, 'Content of the comment'
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

  def index
    comments = Comment.all
    render json: comments
  end

  def show
    render json: @comment
  end

  def create
    comment = Comment.create create_params

    if comment.persisted?
      ActionCable.server.broadcast "comment_channel", comment: @comment
      render json: { message: I18n.t("comment.created") }
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  def update
    @comment.update update_params

    if @comment.persisted?
      ActionCable.server.broadcast "comment_channel", comment: @comment
      render json: { message: I18n.t("comment.updated") }
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy

    if @comment.destroyed?
      ActionCable.server.broadcast "comment_channel", comment: nil
      render json: { message: I18n.t("comment.deleted") }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def create_params
      params.require(:comment).permit(:user_id, :content, :created_at)
    end

    def update_params
      params.require(:comment).permit(:user_id, :content)
    end
end
