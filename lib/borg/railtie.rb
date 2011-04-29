require "rails"
require "eventmachine"
require "redis"
require "socket"
require "rspec-rails"                                                                                                                                                                                                                                    
require "rspec/core"  

require File.join(File.dirname(__FILE__),'cli')
require File.join(File.dirname(__FILE__),'file_splitter')
require File.join(File.dirname(__FILE__),'borg_abstract_adapter')
require File.join(File.dirname(__FILE__),'borg_daemon')
require File.join(File.dirname(__FILE__),'borg_config')
require File.join(File.dirname(__FILE__),'borg_cucumber')
require File.join(File.dirname(__FILE__),'borg_git')
require File.join(File.dirname(__FILE__),'borg_messages')

require File.join(File.dirname(__FILE__),'borg_requestor')
require File.join(File.dirname(__FILE__),'borg_server')

require File.join(File.dirname(__FILE__),'rspec_runner')
require File.join(File.dirname(__FILE__),'borg_rspec_unit')
require File.join(File.dirname(__FILE__),'borg_test_unit')
require File.join(File.dirname(__FILE__),'borg_worker')


module Borg
  class Railtie < Rails::Railtie
    config.after_initialize do
      Borg::Config.load_config("#{Rails.root}/config/borg.yml")
    end
    rake_tasks do
      load File.join(File.dirname(__FILE__),'borg_tasks.rake')
    end
  end
end
