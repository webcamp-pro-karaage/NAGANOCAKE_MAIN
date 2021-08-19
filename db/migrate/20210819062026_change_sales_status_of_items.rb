class ChangeSalesStatusOfItems < ActiveRecord::Migration[5.2]
  def up
    change_column :items, :sales_status, :boolean, default: 'true'
  end
  
  def down
    change_column :items, :sales_status, :boolean
  end
end
