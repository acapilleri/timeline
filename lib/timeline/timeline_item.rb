class TimelineItem < ActiveRecord::Base
  attr_accessible :item_id, :model_name, :action, :_changes
  serialize :_changes
end