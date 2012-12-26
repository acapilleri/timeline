module Timeline
  class Timeline < ActiveRecord::Base
    attr_accessible :action, :item_id, :model_changes, :model_name
    serialize :model_changes
  end
end
