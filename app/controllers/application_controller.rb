class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
  include Encrypt

end
