class CreateModelsTimelineTracks < ActiveRecord::Migration
  def change
    create_table :models_timeline_tracks do |t|
      t.integer :item_id
      t.string :model_name
      t.string :action
      t.string :model_changes

      t.timestamps
    end
    add_index(:models_timeline_tracks, :item_id)
    add_index(:models_timeline_tracks, :model_name)
  end
end
