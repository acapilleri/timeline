module Timeline
  module ModelAdditions
    def self.extended(obj) #:nodoc
      obj.send :include, Timeline::ClassMethods
    end

    # To track your model changes call <tt> timeline </tt>
    # in any Active Record model class.
    #
    #   class Product < ActiveRecord::Base
    #     timeline
    #   end
    #
    # To track only one or a set of attributes(columns) call <tt> timeline :attr1, :attr2 </tt>.
    #
    #   class Product < ActiveRecord::Base
    #     timeline :price, :description
    #   end
    #
    def timeline(*attrs)
      track(attrs)
    end

  private
    def track(attributes)
      after_create do |record|
        map_attributes_and_save('created', attributes)
      end

      after_update do |record|
        map_attributes_and_save('updated', attributes)
      end

      after_destroy do |record|
        map_attributes_and_save('destroyed', attributes)
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