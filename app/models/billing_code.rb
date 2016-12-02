class BillingCode < ApplicationRecord
  has_and_belongs_to_many :related,
    join_table: 'related_billing_codes',
    foreign_key: 'first_billing_code_id',
    association_foreign_key: 'second_billing_code_id',
    class_name: 'BillingCode',
    after_add: :reciprocate,
    after_remove: :cleanup

  def reciprocate(other_billing_code)
    unless other_billing_code.related.include?(self)
      other_billing_code.related << self
    end
  end

  def cleanup(other_billing_code)
    if other_billing_code.related.include?(self)
      other_billing_code.related.delete(self)
    end
  end
end
