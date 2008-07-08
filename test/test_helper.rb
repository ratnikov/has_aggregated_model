ENV["RAILS_ENV"] = "test"
require File.expand_path(File.join(File.dirname(__FILE__), '../../../../config/environment.rb'))
require 'test_help'

#ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + '/debug.log')
config = YAML::load(IO.read(File.join(File.dirname(__FILE__), 'database.yml')))

FileUtils.rm File.join(RAILS_ROOT, config['sqlite3'][:dbfile]), :force => true

ActiveRecord::Base.establish_connection(config['sqlite3'])

load(File.join(File.dirname(__FILE__), "schema.rb"))

files = Dir.glob(File.dirname(__FILE__) + "/../lib/**/*.rb")
files.each do |file|
  require file
end

require File.dirname(__FILE__) + '/test_models'

FixtureReplacement.defaults_file = File.dirname(__FILE__)+'/example_data'
require File.dirname(__FILE__)+'/../../fixture_replacement2/lib/fixture_replacement'

class Test::Unit::TestCase #:nodoc:

  uses_test_tools
  include FixtureReplacement
  include Webitects::DbMonitor

  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures = false
end
