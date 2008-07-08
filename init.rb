require File.dirname(__FILE__)+ '/lib/has_aggregated_model'
ActiveRecord::Base.send :include, Webitects::HasAggregatedModel
