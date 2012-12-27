module Timeline
  module ModelAdditions
    def self.extended(obj)
      obj.send :include, Timeline::ClassMethods
    end

    def timeline(*attrs)
      track(attrs)
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

      model_changes = unless attributes.empty?
       HashWithIndifferentAccess.new self.changes.select{|c| attributes.include?(c)}
      else
        self.changes
      end

      model_changes.delete(:created_at)
      model_changes.delete(:updated_at)

      Track.create!({
        item_id: self.id,
        model_name: self.class.model_name,
        action: action,
        model_changes: model_changes })
      end
    end
  end