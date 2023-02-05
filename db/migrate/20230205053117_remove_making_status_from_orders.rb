class RemoveMakingStatusFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :making_status, :integer
  end
end
