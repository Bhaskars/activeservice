# Activeservice


This gem is created for projects which do not require a backend/database,
but still need all the niceties offered by the ActiveModel

## Installation

Add this line to your application's Gemfile:

    gem 'activeservice'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activeservice

## Usage

Example
=======

class Person < Activeservice::Base

    attr_accessor :name, :age, :book

    attr_reader :account_number
    attr_writer :address
end

class Book < Activeservice::Base

    attr_accessor :author, :category

end

params = {"name" =>"testmeparams", "age" => "25", "book" =>["wewrwrwr", "werwrwrr"]}

params1 = {:name =>"testmeparams", :age => "25", :book => {:author =>"my name", :category => "fiction"}}

p = Person.new(params)

p1 = Person.new(params1)

puts p.attributes

puts p.attributes.inspect

#temp

@book = Book.new
@book.assign_attributes(p1.book)

# with the association added, this should be automatic.


TODO:

* Association, 
* mass assignments should be added later.... 
*

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
