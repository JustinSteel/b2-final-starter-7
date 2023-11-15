class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  validates_presence_of :percentage_discount, :quantity_threshold

  
end