require 'tty-prompt'
require 'code_test_data/generator'

module CodeTestData
  module Commands
    class Generate
      ##
      # Default number of organizations to generate
      #
      DEFAULT_NUMBER_OF_ORGS = 20.freeze

      ##
      # Default number of users to generate
      #
      DEFAULT_NUMBER_OF_USERS = 200.freeze

      ##
      # Default number of tickets to generate
      #
      DEFAULT_NUMBER_OF_TICKETS = 1000.freeze

      def initialize(options)
        @options = options
        @prompt = TTY::Prompt.new
      end

      def run
        output_location = @options.out
        output_location ||= @prompt.ask('Please specify output location', default: Dir.pwd)

        org_count = @options.orgs
        org_count ||= @prompt.ask('Please specify number of organizations', default: DEFAULT_NUMBER_OF_ORGS)

        user_count = @options.users
        user_count ||= @prompt.ask('Please specify number or users', default: DEFAULT_NUMBER_OF_USERS)

        ticket_count = @options.tickets
        ticket_count ||= @prompt.ask('Please specify number of tickets', default: DEFAULT_NUMBER_OF_TICKETS)

        CodeTestData::Generator.generate(
          output_location,
          org_count.to_i,
          user_count.to_i,
          ticket_count.to_i
        )
      end
    end
  end
end
