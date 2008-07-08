ActiveRecord::Schema.define :version => 0 do
  
  create_table :foos, :force => true do |t|
    t.string :name
    t.string :bar_name
  end

  create_table :bars, :force => true do |t|
    t.string :name
    t.belongs_to :foo
  end
end
