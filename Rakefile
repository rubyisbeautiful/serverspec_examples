require 'rspec/core/rake_task'

task :serverspec    => 'serverspec:all'
task :default => :serverspec

desc 'a debug task to show what targets are found'
task :targets do
  targets = []
  Dir.glob('spec/**/*_spec.rb').each do |file|
    host = /(.*)_spec.rb/.match(File.basename(file))[1]
    targets << host
  end
  puts targets
end


namespace :serverspec do
  targets = []
  Dir.glob('spec/**/*_spec.rb').each do |file|
    host = /(.*)_spec.rb/.match(File.basename(file))[1]
    targets << host
  end

  task :all     => targets
  task :default => :all


  targets.each do |target|
    desc "Run serverspec tests to #{target}"
    RSpec::Core::RakeTask.new(target.to_sym) do |t|
      ENV['TARGET_HOST'] = target
      t.pattern = "#{target}_spec.rb"
    end
  end
end
