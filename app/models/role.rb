class Role < ActiveRecord::Base
  belongs_to :user
  enum role_type: [:manager, :worker]
end
