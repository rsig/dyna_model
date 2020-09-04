module DynaModel
  module Attributes
    extend ActiveSupport::Concern

    module ClassMethods

      # Adds a string attribute to this class.
      #
      # @example A standard string attribute
      #
      #   class Recipe < Aws::Record::HashModel
      #     string_attr :name
      #   end
      #
      #   recipe = Recipe.new(:name => "Buttermilk Pancakes")
      #   recipe.name #=> 'Buttermilk Pancakes'
      #
      # @example A string attribute with `:set` set to true
      #
      #   class Recipe < Aws::Record::HashModel
      #     string_attr :tags, :set => true
      #   end
      #
      #   recipe = Recipe.new(:tags => %w(popular dessert))
      #   recipe.tags #=> #<Set: {"popular", "desert"}>
      #
      # @param [Symbol] name The name of the attribute.
      # @param [Hash] options
      # @option options [Boolean] :set (false) When true this attribute
      #   can have multiple values.
      def string_attr name, options = {}
        add_attribute(Aws::Record::Attributes::ClassMethods::string_attr(name, options))
      end

      # Adds an integer attribute to this class.
      #
      #     class Recipe < Aws::Record::HashModel
      #       integer_attr :servings
      #     end
      #
      #     recipe = Recipe.new(:servings => '10')
      #     recipe.servings #=> 10
      #
      # @param [Symbol] name The name of the attribute.
      # @param [Hash] options
      # @option options [Boolean] :set (false) When true this attribute
      #   can have multiple values.
      def integer_attr name, options = {}
        add_attribute(Aws::Record::Attributes::ClassMethods::integer_attr(name, options))
      end

      # Adds a float attribute to this class.
      #
      #     class Listing < Aws::Record::HashModel
      #       float_attr :score
      #     end
      #
      #     listing = Listing.new(:score => '123.456')
      #     listing.score # => 123.456
      #
      # @param [Symbol] name The name of the attribute.
      # @param [Hash] options
      # @option options [Boolean] :set (false) When true this attribute
      #   can have multiple values.
      def float_attr name, options = {}
        add_attribute(Aws::Record::Attributes::ClassMethods::float_attr(name, options))
      end

      # Adds a boolean attribute to this class.
      #
      # @example
      #
      #   class Book < Aws::Record::HashModel
      #     boolean_attr :read
      #   end
      #
      #   b = Book.new
      #   b.read? # => false
      #   b.read = true
      #   b.read? # => true
      #
      #   listing = Listing.new(:score => '123.456'
      #   listing.score # => 123.456
      #
      # @param [Symbol] name The name of the attribute.
      def boolean_attr name, options = {}

        attr = add_attribute(Aws::Record::Attributes::ClassMethods::boolean_attr(name, options))

        # add the boolean question mark method
        define_method("#{attr.name}?") do
          !!__send__(attr.name)
        end

      end

      # Adds a datetime attribute to this class.
      #
      # @example A standard datetime attribute
      #
      #   class Recipe < Aws::Record::HashModel
      #     datetime_attr :invented
      #   end
      #
      #   recipe = Recipe.new(:invented => Time.now)
      #   recipe.invented #=> <DateTime ...>
      #
      # If you add a datetime_attr for `:created_at` and/or `:updated_at` those
      # will be automanaged.
      #
      # @param [Symbol] name The name of the attribute.
      #
      # @param [Hash] options
      #
      # @option options [Boolean] :set (false) When true this attribute
      #   can have multiple date times.
      #
      def datetime_attr name, options = {}
        add_attribute(Aws::Record::Attributes::ClassMethods::dateTime_attr(name, options))
      end

      # Adds a date attribute to this class.
      #
      # @example A standard date attribute
      #
      #   class Person < Aws::Record::HashModel
      #     date_attr :birthdate
      #   end
      #
      #   baby = Person.new
      #   baby.birthdate = Time.now
      #   baby.birthdate #=> <Date: ....>
      #
      # @param [Symbol] name The name of the attribute.
      #
      # @param [Hash] options
      #
      # @option options [Boolean] :set (false) When true this attribute
      #   can have multiple dates.
      #
      def date_attr name, options = {}
        add_attribute(Aws::Record::Attributes::ClassMethods::date_attr(name, options))
      end

      # Adds a DynamoDB binary attribute to this class.  A binary
      # attribute acts the same as a string attribute, except
      #
      # @param [Symbol] name The name of the attribute.
      #
      # @param [Hash] options
      #
      # @option options [Boolean] :set (false) When true this attribute
      #   can have multiple values.
      #
      # @note This should not be used for large objects.
      #
      def binary_attr name, options = {}
      end

      def serialized_attr name, options = {}
        add_attribute(Aws::Record::Attributes::ClassMethods::serialized_attr(name, options))
      end

      # A convenience method for adding the standard two datetime attributes
      # `:created_at` and `:updated_at`.
      #
      # @example
      #
      #   class Recipe < Aws::Record::HashModel
      #     timestamps
      #   end
      #
      #   recipe = Recipe.new
      #   recipe.save
      #   recipe.created_at #=> <DateTime ...>
      #   recipe.updated_at #=> <DateTime ...>
      #
      def timestamps
        c = datetime_attr :created_at
        u = datetime_attr :updated_at
        [c, u]
      end

    end

  end
end
