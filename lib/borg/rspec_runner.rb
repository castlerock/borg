class RspecRunner < RSpec::Core::Runner
  def self.run_tests(argv)
    options = ::RSpec::Core::ConfigurationOptions.new(argv)
    options.parse_options
    RSpec::Core::Runner.instance_variable_set(:@autorun_disabled, true)
    ::RSpec::Core::CommandLine.new(options, RSpec::configuration, RSpec::world).run($stderr, $stdout)
  end

  def self.autorun
    return true
  end
end
