module CodeTestData
  module Models
    class Ticket < Hashie::Mash
      ##
      # Creates a ticket associated with given organization and
      # user
      #
      # @param [CodeTestData::Models::Organization] org
      # @param [CodeTestData::Models::User] user
      #
      # @return [CodeTestData::Models::Ticket]
      #
      def self.make(id, user)
        created_at = Faker::Date.between(from: user.created_at, to: Date.today)

        new(
          _id: id,
          url: "http://initech.zendesk.com/api/v2/tickets/#{id}.json",
          external_id: SecureRandom.uuid,
          created_at: created_at,
          type: 'incident',
          subject: Faker::Lorem.word,
          description: Faker::Lorem.word,
          priority: 'low',
          status: 'hold',
          submitter_id: user.id,
          assignee_id: Faker::Number.number(digits: 2),
          organization_id: user.organization_id,
          tags: [
            Faker::Lorem.word,
            Faker::Lorem.word,
            Faker::Lorem.word,
            Faker::Lorem.word,
          ],
          has_incidents: Faker::Boolean.boolean,
          due_at: Faker::Date.between(from: created_at, to: Date.today),
          via: 'support'
        )
      end

      def id
        self[:_id]
      end
    end
  end
end
