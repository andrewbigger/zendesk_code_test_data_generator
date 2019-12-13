require 'faker'
require 'logger'
require 'byebug'
require 'securerandom'
require 'date'

module CodeTestData
  # Test data generator model namespace
  module Models
    ##
    # generate_org creates a hash representing a code test
    # representation of an organisation
    def generate_org(num)
      {
        _id: num,
        url: "http://initech.zendesk.com/api/v2/organizations/#{num}.json",
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
      }
    end

    ##
    # generate_user creates a hash representing a code test
    # representation of a user, associated to a given organisation
    def generate_user(num, org)
      {
        _id: num,
        url: "http://initech.zendesk.com/api/v2/users/#{num}.json",
        external_id: SecureRandom.uuid,
        name: Faker::Name.name,
        alias: Faker::Name.name_with_middle,
        created_at: Faker::Date.between(from: org[:created_at], to: Date.today),
        active: Faker::Boolean.boolean,
        verified: Faker::Boolean.boolean,
        shared: Faker::Boolean.boolean,
        locale: 'de-CN',
        timezone: Faker::Hipster.word,
        last_login_at: Faker::Date.between(from: org[:created_at], to: Date.today),
        email: Faker::Internet.safe_email,
        phone: Faker::PhoneNumber.phone_number,
        signature: Faker::Lorem.word,
        organization_id: org[:_id],
        tags: [
          Faker::Lorem.word,
          Faker::Lorem.word,
          Faker::Lorem.word,
          Faker::Lorem.word,
        ],
        suspended: Faker::Boolean.boolean,
        role: 'end-user',
      }
    end

    ##
    # generate_ticket creates a hash representing a code test
    # representation of a ticket
    def generate_ticket(user)
      id = SecureRandom.uuid
      created_at = Faker::Date.between(from: user[:created_at], to: Date.today)
      {
        _id: id,
        url: "http://initech.zendesk.com/api/v2/tickets/#{id}.json",
        external_id: SecureRandom.uuid,
        created_at: created_at,
        type: 'incident',
        subject: Faker::Lorem.word,
        description: Faker::Lorem.word,
        priority: 'low',
        status: 'hold',
        submitter_id: user[:_id],
        assignee_id: Faker::Number.number(digits: 2),
        organization_id: user[:organization_id],
        tags: [
          Faker::Lorem.word,
          Faker::Lorem.word,
          Faker::Lorem.word,
          Faker::Lorem.word,
        ],
        has_incidents: Faker::Boolean.boolean,
        due_at: Faker::Date.between(from: created_at, to: Date.today),
        via: 'support'
      }
    end
  end
end
