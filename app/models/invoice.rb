class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def discounted_revenue
    invoice_items
    .joins(item: {merchant: :bulk_discounts})
    .sum("invoice_items.unit_price * invoice_items.quantity * (1 - bulk_discounts.percentage_discount / 100.0)")
  end
end
