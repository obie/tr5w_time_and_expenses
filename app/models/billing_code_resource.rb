class BillingCodeResource < ApplicationRecord
  self.site = "http://localhost:3000/clients/:client_id"
  self.element_name = "billing_code"
end
