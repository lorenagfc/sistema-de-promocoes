class AddOrderToCoupon < ActiveRecord::Migration[6.0]
  def change
    add_column :coupons, :order, :string
  end
end