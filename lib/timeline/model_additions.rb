module Timeline
  module ModelAdditions
    def self.extended(obj)
      obj.send :include, Timeline::ClassMethods
    end

    def timeline
      track(self.attributes)
    end

    def timeline(*attributes)
      track(attributes)
    end

    def track(attributes)
      after_create do |record|
        map_attributes_and_save('create', attributes)
      end

      after_update do |record|
        map_attributes_and_save('update', attributes)
      end

      after_destroy do |record|
        map_attributes_and_save('destroy', attributes)
      end
    end
  end

  module ClassMethods
    def map_attributes_and_save(action, attributes={})
      attributes = attributes.map{|a| a.to_s unless a.is_a? String}
      _changes = unless attributes.empty?
        self.changes.select {|c| attributes.include?(c) }
      else
        self.changes
      end

      TimelineItem.create!({ item_id: self.id,
        model_name: self.class.model_name,
        action: action,
        _changes: _changes })
      end
    end
  end

