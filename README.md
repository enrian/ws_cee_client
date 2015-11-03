# WsCeeClient

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ws_cee_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ws_cee_client

## Usage

You need to obtain username and password from Bisnode first. 

### Find causes for company

```ruby
  ws_client = WsCee::Client.new username: WS_CEE_USERNAME, password: WS_CEE_PASSWORD
  causes = ws_client.find_by_company registration_number: 123456789
```

### Find causes for person

```ruby
  ws_client = WsCee::Client.new username: WS_CEE_USERNAME, password: WS_CEE_PASSWORD
  causes = ws_client.find_by_person name: 'John Doe', date_of_birth: '1969-03-14'
```

The result for both cases is array of WsCee::CauseInfo objects with following attributes.

Example:
 
```ruby
  # WsCee::CauseInfo
  causes.first.code => "144 EX 150/10"
  causes.first.document_type => "Nařízení exekuce"
  causes.first.registration_date => 2013-04-10
  causes.first.subject => instance of WsCee::Subject class

  # WsCee::Subject
  subject = causes.first.subject 
  subject.name => "Company s.r.o."
  subject.address => "Bořivojova 1/10, Praha 1, 110 00"
  subject.registration_id => 123456789
  subject.date_of_birth => nil in case of companies
```

### Details of one cause

```ruby
  cause_detail = ws_client.cause_detail cause_code: "144 EX 150/10"
```

The result is instance of WsCee::CauseDetail.


```ruby
  # WsCee::CauseDetail
  cause_detail.code => "144 EX 150/10"
  cause_detail.description => "peněžité plnění:15018,00"
  cause_detail.documents => array of WsCee::Document objects

  # WsCee::Document
  document = cause_detail.documents.first
  document.type => "Nařízení exekuce"
  document.description => ""
  document.executor_company => "Košina Kamil Mgr."
  document.court => "OS Mělník"
  document.reference_number => "14EXE5105/2011-12"
  document.issue_date => 2010-09-27 
  document.one_time_price => "15018.00"
  document.regular_price  => "15018.00"
  document.non_monetary => nil
  document.subjects => array of WsCee::Subject objects. See previous example
```

Please refer to the WS CEE API documentation for more info about meaning of these attributes.

## Development

After checking out the repo, run `bundle install` to install dependencies. Then, run `rake test` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/enrian/ws_cee_client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

