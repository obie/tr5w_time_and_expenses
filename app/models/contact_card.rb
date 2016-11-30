class ContactCard < ApplicationRecord
  belongs_to :client
  belongs_to :contact, :polymorphic => true
end
