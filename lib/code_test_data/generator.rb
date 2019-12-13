require 'highline'

require_relative 'models'

module CodeTestData
  # Code Test data generators
  module Generator
    class <<self
      include CodeTestData::Models

      ##
      # generate files for search code test
      #
      def generate(output_location, org_count, user_count, ticket_count)
        orgs = generate_organisations(org_count)
        users = generate_users(user_count, orgs)
        tickets = generate_tickets(ticket_count, users)

        write_data(output_location, data: 
          {
            'organizations.json' => orgs,
            'users.json' => users,
            'tickets' => tickets
          }
        )
      end

      private

      ##
      # generate_organisations builds a number of organisations
      #
      def generate_organisations(count)
        raise 'unknown org count' unless count > 1

        (1..count).map do |org_num|
          generate_org(org_num)
        end
      end

      ##
      # generate_users builds a number of users
      #
      def generate_users(count, orgs)
        raise 'unknown user count' unless count > 1

        (1..count).map do |user_num|
          user_org = orgs.sample
          generate_user(user_num, user_org)
        end
      end

      ##
      # generate_tickets builds a number of tickets
      #
      def generate_tickets(count, users)
        raise 'unknown ticket count' unless count > 1

        (1..count).map do
          ticket_user = users.sample
          generate_ticket(ticket_user)
        end
      end

      ##
      # write_data writes json files from given models
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
