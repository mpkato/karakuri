class UsersController < ApplicationController
  autocomplete :user, :username, full: true
end
