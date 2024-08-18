# frozen_string_literal: true

begin
  require 'rubycritic/rake_task'

  RubyCritic::RakeTask.new do |task|
    options = %w[
      --path rubycritic/
      --no-browser
    ]
    task.options = options.join(' ')
    task.paths   = %w[source]
  end
rescue LoadError
  nil
end
