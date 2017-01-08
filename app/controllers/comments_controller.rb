class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]

  # include Swagger::Blocks
  #
  # swagger_path '/comments' do
  #   operation :get do
  #     key :description, 'Returns all comments from the system'
  #     key :operationId, 'getComments'
  #     key :produces, [
  #       'application/json',
  #       'text/html',
  #     ]
  #     key :tags, [
  #       'comment'
  #     ]
  #     parameter do
  #       key :name, :tags
  #       key :in, :query
  #       key :description, 'tags to filter by'
  #       key :required, false
  #       key :type, :array
  #       items do
  #         key :type, :string
  #       end
  #       key :collectionFormat, :csv
  #     end
  #     parameter do
  #       key :name, :limit
  #       key :in, :query
  #       key :description, 'maximum number of results to return'
  #       key :required, false
  #       key :type, :integer
  #       key :format, :int32
  #     end
  #     response 200 do
  #       key :description, 'comment response'
  #       schema do
  #         key :type, :array
  #         items do
  #           key :'$ref', :Pet
  #         end
  #       end
  #     end
  #     response :default do
  #       key :description, 'unexpected error'
  #       schema do
  #         key :'$ref', :ErrorModel
  #       end
  #     end
  #   end
  # end
  #

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
    param :form, :username, :string, :required, 'Username of the comment'
    param :form, :email, :string, :required, 'Email of the comment'
    param :form, :content, :text, :required, 'Content of the comment'
    param :form, :created_at, :datatime, :required, 'Creation date of the comment'
    response :not_acceptable
    response :unprocessable_entity
  end

  swagger_api :update do
    summary 'Update the comment'
    notes 'Update a comment'
    param :path, :id, :integer, :required, 'Id of the comment to update'
    param :form, :username, :string, :optional, 'Username of the comment'
    param :form, :email, :string, :optional, 'Email of the comment'
    param :form, :content, :text, :optional, 'Content of the comment'
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
    @comments = Comment.all

    render json: @comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
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
      params.require(:comment).permit(:username, :email, :content, :created_at)
    end
end
