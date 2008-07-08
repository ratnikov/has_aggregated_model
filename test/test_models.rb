module TestModels
  class Bar < ActiveRecord::Base
    validates_presence_of :name
    belongs_to :foo, :class_name => "Foo"
  end
  
  class Foo < ActiveRecord::Base
    aggregates_one :bar, :class_name => TestModels::Bar

    validates_presence_of :name
  end
end
