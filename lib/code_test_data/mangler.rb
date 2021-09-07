require 'json'
require 'faker'

require_relative 'models'

module CodeTestData
  # Code Test data generators
  module Mangler
    ##
    # Functions for generating new data
    #
    TYPES = {
      String => -> { Faker::Lorem.word },
      Integer => -> { Faker::Number.number(digits: 2) },
      Array => -> { [Faker::Number.number(digits: 2), Faker::Lorem.word] },
      TrueClass => true,
      FalseClass => false
    }.freeze

    class <<self
      include CodeTestData::Models

      ##
      # Distorts given file to test robustness
      #
      # @param [String] input_location
      # @param [Integer] distortion
      #
      def mangle(input_location, distortion = 5)
        data = read_data(input_location)

        wrecked_data = data.map do |item|
          cached_item = item

          (1..distortion).each do
            cached_item = damage_data(cached_item)
          end

          cached_item
        end

        write_data(input_location, wrecked_data)
      end

      private

      ##
      # Damages given item
      #
      # @param [Hash] item
      #
      # @return [Hash]
      #
      def damage_data(item)
        do_thing = rand(1..4)
        case do_thing
        when 1
          delete_key(item)
        when 2
          change_random_value(item)
        else
          item
        end
      end

      ##
      # Destroys a random value from hash
      #
      # @param [Hash] item
      #
      # @return [Hash]
      #
      def delete_key(item)
        new_item = {}
        key = item.keys.sample

        item.reject do |k,v|
          key == k
        end.each do |k,v|
          new_item[k] = v
        end

        new_item
      end

      ##
      # Changes data in given hash
      #
      # @param [Hash] item
      #
      # @return [Hash]
      #
      def change_random_value(item)
        key = item.keys.sample
        value = item[key]

        other_types = TYPES.reject { |k| k == value.class }
        new_type = other_types.keys.sample

        item[key] = TYPES[new_type].call
        item
      end

      ##
      # Reads json files from given models
      #
      # @param [String] input_location
      #
      # @return [Hash]
      #
      def read_data(input_location)
        raise 'input file does not exist' unless File.exist?(input_location)

        JSON.parse(File.read(input_location))
      end

      ##
      # Writes json data to disk
      #
      # @param [String] output_location
      # @param [Hash] data
      #
      def write_data(output_location, data)
        unless File.exist?(output_location)
          raise 'output location does not exist or is not a file'
        end

        File.open(output_location+"_mangled", 'w') { |f| f.write(data.to_json) }
      end
    end
  end
end
