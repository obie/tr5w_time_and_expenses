class Player < ApplicationRecord
  has_many :positions
  has_many :teams, :through => :positions
end