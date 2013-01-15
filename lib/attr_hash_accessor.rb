require 'attr_hash_accessor/version'

require 'active_model/naming'
require 'active_model/conversion'
require 'active_support/core_ext/object/blank'
require 'active_support/hash_with_indifferent_access'

module AttrHashAccessor
  include ActiveModel::Conversion

  module Utils
    extend self

    def normalize_arg(val)
      return {} unless val.present?
      raise  ArgumentError, 'argument should be a Hash' unless val.is_a?(Hash)

      val.stringify_keys
    end
  end

  def self.included(base)
    base.extend ActiveModel::Naming
    base.extend ClassMethods
  end

  def initialize(val = nil)
    @attributes = self.class.default.stringify_keys.merge(Utils.normalize_arg(val))
  end

  def attributes
    @attributes.keys.each_with_object({}) do |key, attrs|
      next unless respond_to?(key)
      attrs[key] = __send__(key)
    end
  end

  def persisted?
    false
  end

  module ClassMethods
    def attr_hash_writer(*cols)
      cols.each do |attr|
        class_eval "def #{attr}=(val); @attributes['#{attr}'] = val; end"
      end
    end

    def attr_hash_reader(*cols, &filter)
      cols.each do |attr|
        define_method(attr) do
          val = @attributes[attr.to_s]
          filter ? filter.call(val) : val
        end
      end
    end

    def attr_hash_accessor(*cols, &filter)
      attr_hash_writer *cols
      attr_hash_reader *cols, &filter
    end

    def default
      {}
    end
  end
end
