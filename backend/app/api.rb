require_relative "../config/initializers/base.rb"

class Api < Hanami::API
  use Hanami::Middleware::BodyParser, :json
  use ErrorHandler

  get "/" do
    "Hello, world"
  end

  post "/users" do
    token = UserService.new.create(
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    response_body = {
      token: token
    }.to_json

    [201, response_body]
  end

  post "/users/login" do
    token = UserService.new.login(
      email: params[:email],
      password: params[:password],
    )
    response_body = {
      token: token
    }.to_json

    [201, response_body]
  end
end