class Person < ApplicationRecord
  has_many :contact_cards, :as => :contact
end
