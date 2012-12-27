module Timeline
  class Track < ActiveRecord::Base
    serialize :model_changes
    attr_accessible :action, :item_id, :model_changes, :model_name
  end
end
