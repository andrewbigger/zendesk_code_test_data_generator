require 'tty-prompt'
require 'code_test_data/generator'

module CodeTestData
  module Commands
    class Generate
      def initialize(options)
        @options = options
        @prompt = TTY::Prompt.new
      end

      def run
        output_location = @options.out
        output_location ||= @prompt.ask('Please specify output location', default: Dir.pwd)

        org_count = @options.orgs
        user_count = @options.users
        ticket_count = @options.tickets

        CodeTestData::Generator.generate(
          output_location,
          org_count,
          user_count,
          ticket_count
        )
      end
    end
  end
end
