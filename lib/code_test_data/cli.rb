require 'thor'
require 'code_test_data/commands'

module CodeTestData
  # Command Line Interface
  class CLI < Thor
    package_name 'Code Test Data'

    desc 'version', 'Print version'

    def version
      cmd = CodeTestData::Commands::Version.new(options)
      cmd.run
    end

    desc 'generate', 'Generate code test data'

    method_option(
      :out,
      type: :string,
      desc: 'Path to write data files'
    )

    method_option(
      :orgs,
      type: :numeric,
      desc: 'Number of organizations to create'
    )

    method_option(
      :users,
      type: :numeric,
      desc: 'Number of users to create'
    )

    method_option(
      :tickets,
      type: :numeric,
      desc: 'Number of tickets to create'
    )

    def generate
      cmd = CodeTestData::Commands::Generate.new(options)
      cmd.run
    end

    desc 'mangle', 'Distort code test data'

    method_option(
      :in,
      type: :string,
      desc: 'Path of file to distort',
    )

    method_option(
      :distortion,
      type: :numeric,
      desc: 'Amount of distortion to apply',
      default: 5
    )

    def mangle
      cmd = CodeTestData::Commands::Mangle.new(options)
      cmd.run
    end
  end
end
