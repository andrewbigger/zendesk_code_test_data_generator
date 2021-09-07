module CodeTestData
  module Models
    class Organization < Hashie::Mash
      ##
      # Creates a new organization with dummy
      # data
      #
      # @param [Integer] id
      #
      # @return [CodeTestData::Models::Organization]
      #
      def self.make(id)
        new(
          _id: id,
          url: "http://initech.zendesk.com/api/v2/organizations/#{id}.json",
          external_id: SecureRandom.uuid,
          name: Faker::Hipster.word,
          domain_names: [
            Faker::Internet.domain_name,
            Faker::Internet.domain_name,
            Faker::Internet.domain_name,
            Faker::Internet.domain_name
          ],
          created_at: Faker::Date.between(from: Date.parse('25/12/2013'), to: Date.today),
          details: Faker::Lorem.word,
          shared_tickets: Faker::Boolean.boolean,
          tags: [
            Faker::Lorem.word,
            Faker::Lorem.word,
            Faker::Lorem.word,
            Faker::Lorem.word,
          ]
        )
      end

      def id
        self[:_id]
      end
    end
  end
end
