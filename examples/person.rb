require_relative '../lib/activeservice/base'

class Person < Activeservice::Base
  attr_accessor :name, :age, :books

  attr_reader :test
  attr_writer :testmewriter

  has_one :books, :class_name => :books

  validates_presence_of :name ,:message => "The field is a required field"
end


#params = { :person =>{:name =>"testme", :age => "25"}, :commit=>"Create Person"}
params = {"name1" =>"testmeparams", "age" => "25", "books" =>["wewrwrwr", "werwrwrr"], :erre =>"wewrwrwrw"}
params1 = {:name1 =>"testmeparams", :age => "25", :books => {:author =>"my name", :category => "fiction"}}

params11 = {:name =>"testmeparams", :age => "25", :books => {:author =>"my name", :category => "fiction"}}

#puts params.inspect
#params = params.with_indifferent_access
#puts params.inspect
#p = Person.new


p = Person.new(params)
p.valid?

p.assign_attributes(params11)
p1 = Person.new(params1)
puts p.attributes
puts p.attributes.inspect
puts p.errors.values.inspect
puts p.inspect
puts p1.inspect

p2 = Person.new

p2.attributes

