class CreateTimelineItems < ActiveRecord::Migration
  create_table :timeline_items,:force=>true do |t|
    t.integer :item_id
    t.string  :item_name
    t.string  :model_name
    t.string  :action
    t.integer :vendor_id
    t.string  :_changes
    t.timestamps
  end
  def self.down
    drop_table :timeline_items
  end
end