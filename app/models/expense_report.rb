class ExpenseReport < ApplicationRecord
  belongs_to :user
  has_many :comments, :as => :subject
end
