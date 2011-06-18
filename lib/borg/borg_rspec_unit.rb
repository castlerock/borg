module Borg
  class RspecTestUnit
    include AbstractAdapter
    def run(n = 1)
      redirect_stdout()
      remove_file_groups_from_redis('tests', n) do |index, rspec_files|
        rspec_files_path = rspec_files.split(',').map do |fl|
          Rails.root.to_s + fl
        end

      failure = RspecRunner.run_tests rspec_files_path.split(',')
        raise "Rspec files failed" if !failure
      end
    end

    def run_custom_files(n=1, file_list = ["spec/models/person_spec.rb"])
      failure = RspecRunner.run_tests file_list
    end

    def add_to_redis(worker_count)
      test_files = units_functionals_list.map do |fl|
        fl.gsub(/#{Rails.root}/, '')
      end.sort.in_groups(worker_count, false)
      add_files_to_redis(test_files, 'tests')
    end

    def units_functionals_list
      if Borg::Config::test_unit_framework != "rake spec"
        (Dir["#{Rails.root}/test/unit/**/**_test.rb"] + Dir["#{Rails.root}/test/functional/**/**_test.rb"])
      else
        (Dir["#{Rails.root}/spec/models/**/**_spec.rb"])
      end
    end
  end
end
