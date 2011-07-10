# encoding: UTF-8
#
module Tddbc
  class Bevarage
     attr_accessor :count
     attr_reader :id, :amount, :name
     def initialize(id, amount, name)
        @id = id
        @amount = amount
        @name = name
        @count = 0
     end

  end
end
