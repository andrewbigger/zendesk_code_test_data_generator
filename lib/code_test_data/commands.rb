COMMANDS = File.join(__dir__, 'commands', '*.rb')

Dir[COMMANDS].sort.each do |file|
  require file
end

module CodeTestData
  # Gem command module
  module Commands
  end
end
