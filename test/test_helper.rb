
$:.unshift(File.expand_path("..", File.dirname(__FILE__)) + '/lib')
require 'pathname'
ENV['RAILS_ENV'] = 'test'

require 'bundler/setup'
require 'rails/all'

if Rails.version >= '4.1'
  require 'minitest/autorun'
else
  require 'test/unit'
end

puts "Testing against rails #{Rails::VERSION::STRING}"

TEST_ROOT = File.dirname(__FILE__)
require 'simple_file_uploader'

class TestApp
  class Application < ::Rails::Application
    config.secret_key_base = "testingpurposesonly"
    config.active_support.deprecation = :stderr
    database_path = File.join(TEST_ROOT, 'database.yml')
    config.eager_load = false
    if Rails.version.start_with? '3.0.'
      config.paths.config.database database_path
    else
      config.paths['config/database'] = database_path
    end
    initialize!
    # load_tasks
    # Rake::Task['db:drop'].invoke
    # Rake::Task['db:create'].invoke
  end
end

# options = {:adapter => 'sqlite3', :timeout => 500, :database => ':memory:'}
# ActiveRecord::Base.establish_connection(options)
# ActiveRecord::Base.configurations = { 'sqlite3_ar_integration' => options }
# ActiveRecord::Base.connection

File.read(File.dirname(__FILE__) + "/schema.sql").split(';').each do |sql|
  ActiveRecord::Base.connection.execute(sql) unless sql.blank?
end


require File.join(TEST_ROOT, 'test_helper/routes')
require File.join(TEST_ROOT, 'test_helper/avatar_uploader')
require File.join(TEST_ROOT, 'test_helper/user')

class ActiveSupport::TestCase

  def pretty_generate(response_body)
    puts JSON.pretty_generate(JSON.parse(response_body))
  end

  def routes
    all_routes = Rails.application.routes.routes
    require 'action_dispatch/routing/inspector'
    inspector = ActionDispatch::Routing::RoutesInspector.new(all_routes)
    inspector.format(ActionDispatch::Routing::ConsoleFormatter.new, ENV['CONTROLLER'])
  end
end