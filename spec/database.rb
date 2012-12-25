$:.unshift(File.dirname(__FILE__) + '/../lib')
$:.unshift(File.dirname(__FILE__) + '/../../rspec/lib')

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => '/tmp/timeline.sqlite')
ActiveRecord::Migration.verbose = false
ActiveRecord::Base.default_timezone = :utc if Time.zone.nil?

ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS 'projects'")
ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS 'timeline_items'")

ActiveRecord::Schema.define do
   create_table :timeline_items,:force=>true do |t|
      t.integer :item_id
      t.string  :item_name
      t.string  :model_name
      t.string  :action
      t.integer :vendor_id
      t.string  :_changes
      t.timestamps
    end

  create_table :projects, :force => true do |table|
    table.string :name
    table.string :description
    table.integer :days
    table.boolean :done
  end
end
