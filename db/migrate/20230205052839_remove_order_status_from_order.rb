class RemoveOrderStatusFromOrder < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :order_status, :integer
  end
end
