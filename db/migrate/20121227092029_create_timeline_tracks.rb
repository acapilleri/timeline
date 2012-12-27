class CreateTimelineTracks < ActiveRecord::Migration
  def change
    create_table :timeline_tracks do |t|
      t.integer :item_id
      t.string :model_name
      t.string :action
      t.string :model_changes

      t.timestamps
    end
    add_index(:timeline_tracks, :item_id)
    add_index(:timeline_tracks, :model_name)
  end
end
