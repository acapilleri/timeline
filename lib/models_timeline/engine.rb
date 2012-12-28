require "models_timeline/engine"
require "models_timeline/model_additions"
require "models_timeline/railtie"

module ModelsTimeline
  class Engine < ::Rails::Engine
    isolate_namespace ModelsTimeline
  end
end
