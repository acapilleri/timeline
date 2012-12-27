module Timeline
  class Railtie < Rails::Railtie
    initializer 'timeline.model_additions' do
      ActiveSupport.on_load :active_record do
        extend ModelAdditions
      end
    end
  end
end