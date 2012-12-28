require_dependency "timeline/application_controller"

module Timeline
  class TracksController < ApplicationController
    def index
      @tracks = Track.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @tracks }
      end
    end

    def show
      @track = Track.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @track }
      end
    end
  end
end
