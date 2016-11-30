class Comment < ApplicationRecord
  belongs_to :subject, :polymorphic => true
end
