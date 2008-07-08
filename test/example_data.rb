module FixtureReplacement
  attributes_for :foo, :class => TestModels::Foo do |f|
    f.name = "name_#{String.random}"
    f.bar_name = "bar_name_#{String.random}"
  end

  attributes_for :bar, :class => TestModels::Bar do |b|
    b.name = "name_#{String.random}"
  end
end
