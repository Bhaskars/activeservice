require 'active_support/all'
require 'active_model/validations'
require 'active_model/naming'
require 'active_model/translation'
require 'active_model/conversion'
require 'active_model/attribute_methods'
require 'active_model/serialization'
require 'active_model/serializers/json'
require 'active_model/mass_assignment_security'
require 'active_support/inflector'
module Activeservice
  class Base
    extend ActiveModel::Naming
    include ActiveModel::Translation
    include ActiveModel::Validations
    include ActiveModel::Conversion
    include ActiveModel::AttributeMethods
    #include ActiveModel::Serializers::JSON
    #include ActiveModel::MassAssignmentSecurity


    # refactor this later to single method to gather all attributes
    def self.attr_accessor(*attrs)
      get_attributes(attrs)
      super(*attrs)
    end

    def self.attr_writer(*attrs)
      get_attributes(attrs)
      super(*attrs)
    end

    def self.attr_reader(*attrs)
      get_attributes(attrs)
      super(*attrs)
    end

    def self.attributes
      @attributes
    end

    def self.get_attributes(attrs)
      @attributes ||= []
      @attributes.concat attrs
    end

    def initialize(attributes = nil, options = {})
      assign_attributes(attributes, options) if attributes
    end

    def self.attr_refers_to_class(klass, options= {})
      puts options.inspect
      if options.nil?
        klass.to_s.constantize
      else
        class_name = options[:class_name].to_s
       class_name.constantize
      end
    end



    def assign_attributes(new_attributes, options = {})
      return unless new_attributes

      #attributes = new_attributes.stringify_keys
      attributes = sanitize_attributes(new_attributes).stringify_keys
      multi_parameter_attributes = []
      @mass_assignment_options = options

      attributes.each do |k, v|
        if k.include?("(")
          multi_parameter_attributes << [ k, v ]
        elsif respond_to?("#{k}=")
          send("#{k}=", v)
        else
          raise(Exception) #( "unknown attribute: #{k}")
        end
      end
    end

    def sanitize_attributes(attributes)
      sanitized_attributes = {}
      attributes.each do |k,v|
        if respond_to?("#{k}=")
          sanitized_attributes[k]=v
        end
      end
      sanitized_attributes
    end

    def persisted?
      false
    end

    def attributes
      self.class.attributes
    end

    def mass_assignment_options
      @mass_assignment_options ||= {}
    end

    def mass_assignment_role
      mass_assignment_options || :default
    end

    def initialize_attributes

    end
  end

end