MadMimi for Rails 2
======

### Install

```console
gem install madmimi_for_rails_two
```

### Use

At the end of your `environment.rb`

```ruby
require 'madmimi_for_rails_two'
ActionMailer::Base.delivery_method = :madmimi
MadMimi.api_settings = {
  :username => 'madmimi_username',
  :api_key => 'madmimi_apikey'
}
```