# This code was taken from https://github.com/thoughtbot/factory_girl/tree/master/lib/factory_girl/syntax
# (blueprint and make) and modified for MongoMapper

module FactoryGirl
  module Syntax

    # Extends MongoMapper::Document to provide a make class method, which is an
    # alternate syntax for defining factories.
    #
    # Usage:
    #
    #   require 'factory_girl/syntax/mongo_mapper'
    #
    #   User.blueprint do
    #     name  { 'Billy Bob'             }
    #     email { 'billy@bob.example.com' }
    #   end
    #
    #   FactoryGirl.create(:user, :name => 'Johnny')
    #
    # This syntax was derived from Pete Yandell's machinist.
    module Blueprint
      module MongoMapper extend ActiveSupport::Concern #:nodoc:

        module ClassMethods #:nodoc:

          def blueprint(&block)
            instance = Factory.new(name.underscore, :class => self)
            proxy = FactoryGirl::DefinitionProxy.new(instance)
            proxy.instance_eval(&block)
            FactoryGirl.register_factory(instance)
          end

        end

      end
    end

    # Extends MongoMapper::Document to provide a make class method, which is a
    # shortcut for FactoryGirl.create.
    #
    # Usage:
    #
    #   require 'factory_girl/syntax/mongo_mapper'
    #
    #   FactoryGirl.define do
    #     factory :user do
    #       name 'Billy Bob'
    #       email 'billy@bob.example.com'
    #     end
    #   end
    #
    #   User.make(:name => 'Johnny')
    #
    # This syntax was derived from Pete Yandell's machinist.
    module Make
      module MongoMapper extend ActiveSupport::Concern #:nodoc:

        module ClassMethods #:nodoc:

          def make(overrides = {})
            FactoryGirl.factory_by_name(name.underscore).run(Proxy::Build, overrides)
          end

          def make!(overrides = {})
            FactoryGirl.factory_by_name(name.underscore).run(Proxy::Create, overrides)
          end

        end

      end
    end
  end
end

MongoMapper::Document.plugin(FactoryGirl::Syntax::Blueprint::MongoMapper)
MongoMapper::Document.plugin(FactoryGirl::Syntax::Make::MongoMapper)
