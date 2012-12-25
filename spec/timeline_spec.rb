require 'spec_helper'

class Project < ActiveRecord::Base
end

Project.send(:extend,Timeline::ModelAdditions)

describe Timeline do
#  it 'url is stored' do
 #   @project = Project.new
  #  @p.name = 'this is the name'
#  end

end

