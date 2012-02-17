Gem::Specification.new do |s|
  s.name    = 'madmimi_for_rails_two'
  s.version = '0.5.0'
  s.summary = 'Use madmimi with Rails 2'

  s.author   = 'Igor Soarez'
  s.email    = 'igorsoarez@gmail.com'
  s.homepage = 'https://github.com/Soarez/madmimi_for_rails_two'

  # Include everything in the lib folder
  s.files = Dir['lib/**/*']

  # Supress the warning about no rubyforge project
  s.rubyforge_project = 'nowarning'
end