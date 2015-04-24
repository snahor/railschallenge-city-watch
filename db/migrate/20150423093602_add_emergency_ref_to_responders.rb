class AddEmergencyRefToResponders < ActiveRecord::Migration
  def change
    add_column :responders, :emergency_id, :int
    add_foreign_key :responders, :emergencies
  end
end
