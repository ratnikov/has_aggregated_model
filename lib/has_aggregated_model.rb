module Webitects #:nodoc:
  module HasAggregatedModel #:nodoc:

    def self.included base
      base.extend(ClassMethods)
    end

    module ClassMethods

      def aggregates_one(model, options = {})

        # custom association to include (via proc). By default does has_one
        # To avoid any association, specify to be nil
        if options.has_key? :custom_association
          association = options.delete :custom_association
          association.call(model) unless association.nil?
        else
          has_one model
        end

        # the class of the aggregated model
        model_class = options[:class_name] || model.to_class

        # hash of field overrides
        fields = options.delete(:fields) || {}

        include Webitects::HasAggregatedModel::InstanceMethods.make_module(model, model_class, fields)
      end
    end

    module InstanceMethods
      def self.make_module(model, model_class, fields)
        Module.new do
          define_method "fill_#{model}" do
            aggregated_model = model_class.create Helpers::make_creation_hash(self, model, model_class, fields)
            self.send("#{model}=", aggregated_model)
          end
        end
      end
    end

    module Helpers

      def self.make_creation_hash(obj, sub_model, sub_model_class, fields = {})
        creation_params = sub_model_class.content_columns.inject({}) do |acc, column|
          aggregated_field = fields[column.name.to_sym] || "#{sub_model}_#{column.name}"

          if obj.has_attribute?(aggregated_field)
            acc.merge({ column.name, obj.send(aggregated_field)})
          end
        end

        creation_params.merge! obj.class.class_name.to_s.underscore => obj
      end
    end
  end
end

class Symbol
  def to_class
    to_s.classify.constantize
  end
end
