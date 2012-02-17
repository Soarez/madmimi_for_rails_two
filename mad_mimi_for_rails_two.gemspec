Gem::Specification.new do |s|
  s.name    = 'mad_mimi_for_rails_two'
  s.version = '0.5.0'
  s.summary = 'Use madmimi with rails 2'

  s.author   = 'Igor Soarez'
  s.email    = 'igorsoarez@gmail.com'
  s.homepage = 'https://github.com/Soarez/mad_mimi_for_rails_two'

  # These dependencies are only for people who work on this gem
  s.add_development_dependency 'madmimi'

  # Include everything in the lib folder
  s.files = Dir['lib/**/*']

  # Supress the warning about no rubyforge project
  s.rubyforge_project = 'nowarning'
end