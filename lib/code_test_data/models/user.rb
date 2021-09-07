module CodeTestData
  module Models
    class User < Hashie::Mash
      ##
      # Creates a user associated with a given organization
      #
      # @param [Integer] id
      # @param [CodeTestData::Models::Organization] org
      #
      # @return [CodeTestData::Models::User]
      #
      def self.make(id, org)
        new(
          _id: id,
          url: "http://initech.zendesk.com/api/v2/users/#{id}.json",
          external_id: SecureRandom.uuid,
          name: Faker::Name.name,
          alias: Faker::Name.name_with_middle,
          created_at: Faker::Date.between(from: org.created_at, to: Date.today),
          active: Faker::Boolean.boolean,
          verified: Faker::Boolean.boolean,
          shared: Faker::Boolean.boolean,
          locale: 'de-CN',
          timezone: Faker::Hipster.word,
          last_login_at: Faker::Date.between(from: org.created_at, to: Date.today),
          email: Faker::Internet.safe_email,
          phone: Faker::PhoneNumber.phone_number,
          signature: Faker::Lorem.word,
          organization_id: org.id,
          tags: [
            Faker::Lorem.word,
            Faker::Lorem.word,
            Faker::Lorem.word,
            Faker::Lorem.word,
          ],
          suspended: Faker::Boolean.boolean,
          role: 'end-user',
        )
      end

      def id
        self[:_id]
      end
    end
  end
end
