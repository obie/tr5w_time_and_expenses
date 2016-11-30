class Business < ApplicationRecord
  has_many :contact_cards, :as => :contact
end
