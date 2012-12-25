require 'spec_helper'

describe Timeline::ModelAdditions do
  it "should class method timeline" do
    Project.respond_to?(:timeline).should  be_true
    Project.respond_to?(:timeline,{}).should  be_true
  end

  describe 'serialization' do
    before :each do
      Project.timeline
      @h = {name: 'angelo', days: 2, done: true}
      @project = Project.create!(@h)
      @item = TimelineItem.find_by_item_id(@project.id)
    end

    after :all do
       @project.destroy
       @item.destroy
    end

    it "should serializes all attributes" do
      @item.should_not be_nil
    end

    it "should has the right model name" do
      @item.model_name.should eql @project.class.model_name
    end

    it "should serializes  attributes" do
      @item.action.should eql 'create'
    end

    it "should serialize changes" do
      @h.map{|k,v| @item._changes[k].should_not be_empty }
    end

     it "should serializes attributes update" do
       @project.update_attributes({name: 'pippo', days: 3})
    end

    it "should serialize update" do
      @project.update_attributes({name: 'pippo', days: 3,  done: false})
      @item = TimelineItem.where({item_id: @project.id, action: 'update'}).first
      @item._changes[:name].should eql ['angelo','pippo']
      @item._changes[:days].should eql [2,3]
      @item._changes[:done].should eql [true, false]
    end

    it "should serialize delete" do
      id = @project.id
      @project.delete
      @item = TimelineItem.where({item_id: id, action: 'destroy'}).first
      @item.should be_nil
    end
  end

  describe "passing attributes" do
    before :each do
      Project.timeline(:name, :days)
      @param = {name: 'angelo', days: 2, done: true}
      @project = Project.create!(@h)
      @item = TimelineItem.find_by_item_id(@project.id)
    end

    it 'should serialize update' do
      @item._changes.include?(:done).should  eql false
    end

    it 'should serialize create' do
      @project.update_attributes({name: 'pippo', days: 3})
      @item._changes.include?(:done).should eql false
    end
  end
end
