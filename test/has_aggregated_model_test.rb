require File.dirname(__FILE__)+'/test_helper'

class Zetum 
  def zetum
  end
end

class HasAggregatedModelTest < Test::Unit::TestCase
  def test_truth
    assert true
  end

  def test_symbol_to_class
    assert_equal Zetum, :zetum.to_class
  end

  def test_make_creation_hash
    foo = new_foo
    creation_hash = Webitects::HasAggregatedModel::Helpers::make_creation_hash(foo, :bar, TestModels::Bar)
    assert_equal foo.bar_name, creation_hash["name"]
    assert_models_match foo, creation_hash["foo"]
  end

  def test_filling
    foo = create_foo
    foo.fill_bar

    bar = foo.bar

    assert_not_nil bar, "Bar was not set."
    assert_equal foo.bar_name, bar.name, "Filled names do not match."
    assert_equal foo, bar.foo, "Parent is not set correctly."
  end

  def test_custom_fields
    foo = create_foo
    creation_hash = Webitects::HasAggregatedModel::Helpers.make_creation_hash(foo, :bar, TestModels::Bar, { :name => :name })
    assert_equal foo.name, creation_hash["name"]
    assert_models_match foo, creation_hash["foo"]
  end
end
