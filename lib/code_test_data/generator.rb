require 'code_test_data/models'

module CodeTestData
  # Code Test data generators
  module Generator
    class <<self
      ##
      # Generates files for search code test
      #
      # @param [String] output_location
      # @param [Integer] org_count
      # @param [Integer] user_count
      # @param [Integer] ticket_count
      #
      def generate(output_location, org_count, user_count, ticket_count)
        orgs = generate_organisations(org_count)
        users = generate_users(user_count, orgs)
        tickets = generate_tickets(ticket_count, users)

        write_data(output_location, data: 
          {
            'organizations.json' => orgs,
            'users.json' => users,
            'tickets.json' => tickets
          }
        )
      end

      private

      ##
      # Builds a number of organisations
      #
      # @param [Integer] count
      #
      # @return [Array]
      #
      def generate_organisations(count)
        raise 'unknown org count' unless count > 1

        (1..count).map do |org_id|
          CodeTestData::Models::Organization.make(org_id)
        end
      end

      ##
      # Builds a number of users
      #
      # @param [Integer] count
      # @param [Array] orgs
      # 
      # @return [Array]
      #
      def generate_users(count, orgs)
        raise 'unknown user count' unless count > 1

        (1..count).map do |user_id|
          CodeTestData::Models::User.make(user_id, orgs.sample)
        end
      end

      ##
      # Builds a number of tickets
      #
      # @param [Integer] count
      # @param [Array] users
      #
      # @return [Array]
      #
      def generate_tickets(count, users)
        raise 'unknown ticket count' unless count > 1

        (1..count).map do |ticket_id|
          CodeTestData::Models::Ticket.make(ticket_id, users.sample)
        end
      end

      ##
      # Writes json files from given models
      #
      # @param [String] output_location
      # @param [Hash] data
      #
      def write_data(output_location, data: {})
        unless Dir.exist?(output_location)
          raise 'output location does not exist or is not directory'
        end

        data.each do |file_name, test_data|
          write_path = File.join(output_location, file_name)
          File.open(write_path, 'w') { |f| f.write(test_data.to_json) }
        end
      end
    end
  end
end
