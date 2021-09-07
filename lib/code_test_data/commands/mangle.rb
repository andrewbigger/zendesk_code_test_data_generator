require 'tty-prompt'
require 'code_test_data/mangler'

module CodeTestData
  module Commands
    class Mangle
      def initialize(options)
        @options = options
        @prompt = TTY::Prompt.new
      end

      def run
        input_location = @options.in
        input_location ||= @prompt.ask('Please specify input location')

        distortion = @options.distortion

        CodeTestData::Mangler.mangle(input_location, distortion)
      end
    end
  end
end
