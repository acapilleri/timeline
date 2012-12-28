require 'test_helper'

module ModelsTimeline
  class TracksControllerTest < ActionController::TestCase
    fixtures 'timeline/tracks'
    setup do
      @track = timeline_tracks(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:tracks)
    end

    test "should show track" do
      get :show, id: @track
      assert_response :success
    end

  end
end
