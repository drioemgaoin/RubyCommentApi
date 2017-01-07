endpoints = {
  "production"  => "http://api.my-service.com",
  "staging"     => "http://api-staging.my-service.com",
  "development" => "http://localhost:3000",
}

Swagger::Docs::Config.base_api_controller = ActionController::API
Swagger::Docs::Config.register_apis({
  "1.0" => {
    api_file_path:       "public/apidocs/",
    base_path:           "#{endpoints[Rails.env]}",
    clean_directory:     true
  }
})

class Swagger::Docs::Config
  def self.transform_path(path, api_version)
    "apidocs/#{path}"
  end
end
