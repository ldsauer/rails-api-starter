class ChangeStatusToBeStringInSubscriptions < ActiveRecord::Migration[7.1]
  def change
    change_column :subscriptions, :status, :string
  end
end
