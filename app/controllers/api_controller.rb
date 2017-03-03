class ApiController < ApplicationController
  def index
    redirect_to '/swagger/dist/index.html?url=/apidocs/api-docs.json'
  end
end
