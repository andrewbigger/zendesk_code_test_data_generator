require_relative 'generator'
require_relative 'mangler'

module CodeTestData
  # Command line interface helpers and actions
  module CLI
    # CLI Actions
    module Commands
      def self.generate(args)
        @cli = HighLine.new

        @output_location = args.shift || @cli.ask(
          'please specify output file location'
        )
        raise 'you must provide an output file location' unless @output_location

        @org_count = args.shift || @cli.ask(
          'please specify organisation count'
        ).to_i
        raise 'you must provide an organisation count' unless @org_count

        @user_count = args.shift || @cli.ask(
          'please specify user count'
        ).to_i
        raise 'you must provide an user count' unless @user_count

        @ticket_count = args.shift || @cli.ask(
          'please specify ticket count'
        ).to_i
        raise 'you must provide an ticket count' unless @ticket_count

        CodeTestData::Generator.generate(
          @output_location,
          @org_count,
          @user_count,
          @ticket_count
        )
      end

      def self.mangle(args)
        @cli = HighLine.new

        @input_location = args.shift || @cli.ask(
          'please specify an input file'
        )
        raise 'you must provide an input file location' unless @input_location

        @distortion = args[3] || @cli.ask(
          'Please specify a distortion value (default: 5)'
        ).to_i

        CodeTestData::Mangler.mangle(@input_location, @distortion)
      end
    end

    # CLI Helpers
    class <<self
      ##
      # Prints command line message to CLI
      #
      def print_message(message)
        puts(message)
      end

      ##
      # Prints a message and then exits with given status code
      #
      def print_message_and_exit(message, exit_code = 1)
        print_message(message)
        exit(exit_code)
      end
    end
  end
end
