require 'test_helper'
require 'debugger'
module Timeline
  class TrackTest < ActiveSupport::TestCase
    self.use_transactional_fixtures = true

    setup do
      Track.destroy_all
    end

    def attr
      {name: 'angelo', days: 2, done: true}
    end

    def new_project
      Project.create!(attr)
    end

    test "test model addition" do
      assert_kind_of Class, Project
      assert_respond_to Project, :timeline
      assert_respond_to Project, :timeline, {}
    end

    test "track all model attributes" do
      Project.timeline
      project = new_project

      track = Track.first
      assert_equal Track.all.count, 1
      assert_equal track.model_name, 'Project'
      #test if all attributes are correctly stored
      attr.each_key do |k|
        assert_equal track.model_changes[k], [nil, attr[k]]
      end

      #update
      project.update_attributes({name: 'pippo'})
      track = Track.first
      assert_equal Track.all.count, 2
      assert_equal track.model_name, 'Project'
      assert_equal track.action, 'updated'
      #test track added on update
      assert_equal track.model_changes.size, 1
      debugger
      assert_equal track.model_changes[:name], ['angelo','pippo']

      #destroy
      project.destroy
      track = Track.first
      assert_equal Track.all.count, 3
      assert_equal track.model_name, 'Project'
      assert_equal track.action, 'destroyed'
      #test track added on update
      assert_equal track.model_changes.size, 0
    end

    test "track all some attributes" do
      Project.reset_callbacks :create
      Project.reset_callbacks :update

      Project.timeline(:name,:days)

      project = Project.create!({name: 'angelo', days: 2, done: true})
      assert_equal Project.all.count, 1
      track = Track.first
      assert_equal track.model_name, 'Project'
      #test if all attributes are correctly stored
      [:name, :days].each do |k|
        assert_equal track.model_changes[k], [nil, attr[k]]
      end

      #update
      project.update_attributes({name: 'tom', days: 4})
      track = Track.first
      assert_equal track.model_name, 'Project'
      assert_equal track.action, 'updated'
      #test track added on update
      assert_equal track.model_changes.size, 2
      assert_equal track.model_changes[:name], ['angelo','tom']
      assert_equal track.model_changes[:days], [2,4]

      #destroy
      project.destroy
      track = Track.first
      assert_equal track.model_name, 'Project'
      assert_equal track.action, 'destroyed'
      #test track added on update
    end

  end
end