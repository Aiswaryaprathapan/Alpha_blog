class Account <ActiveRecord::Base
  belongs_to :user
validates :email, presence:true, length: {maximum: 150},uniqueness: {case_sensitive: false}, length: {maximum: 25},
            format: {with: VALID_EMAIL_REGEX }
validates :address, presence:true
end
