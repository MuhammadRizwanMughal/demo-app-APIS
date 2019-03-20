class User < ApplicationRecord
  validates :email, presence: true, :uniqueness => { :case_sensitive => false }
  validates_uniqueness_of :email
end
