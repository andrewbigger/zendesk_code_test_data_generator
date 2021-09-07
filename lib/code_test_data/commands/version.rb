require 'code_test_data/version'

module CodeTestData
  module Commands
    # Gem version command
    class Version
      def initialize(options)
        @options = options
      end

      ##
      # Prints version to STDOUT
      #
      def run
        puts(CodeTestData::VERSION)
      end
    end
  end
end
