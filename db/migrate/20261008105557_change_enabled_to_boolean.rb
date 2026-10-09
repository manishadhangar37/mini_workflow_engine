class ChangeEnabledToBoolean < ActiveRecord::Migration[8.1]
  def change
    change_column :workflows, :enabled, :boolean,
     using: "enabled::boolean"
  end
end
