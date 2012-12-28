require "timeline/engine"
require "timeline/model_additions"
require "timeline/railtie"

module Timeline
  class Engine < ::Rails::Engine
    isolate_namespace Timeline
  end
end
