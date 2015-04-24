class AddFullResponseDefaultToEmergencies < ActiveRecord::Migration
  def change
    change_column_default :emergencies, :full_response, true
  end
end
