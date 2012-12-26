class CreateTimelineTimelines < ActiveRecord::Migration
  def change
    create_table :timeline_timelines do |t|
      t.integer :item_id
      t.string :model_name
      t.string :action
      t.string :model_changes

      t.timestamps
    end
  end
end
