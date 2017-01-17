Swagger::Docs::Config.base_api_controller = ActionController::API
Swagger::Docs::Config.register_apis({
  "1.0" => {
    api_file_path:       "public/apidocs/",
    base_path:           ENV['URL'],
    clean_directory:     true
  }
})

class Swagger::Docs::Config
  def self.transform_path(path, _api_version)
    "apidocs/#{path}"
  end
end
