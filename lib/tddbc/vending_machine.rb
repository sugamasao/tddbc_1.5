# encoding: UTF-8
#
module Tddbc
  
  class VendingMachine
     attr_accessor :monies, :bevarages, :temp_amount
     attr_reader :invalid_amount
     def initialize
       @monies = [ 1000, 1000, 1000, 1000, 1000, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 100,100,100,100,100,100,100,100,100,100, 50,50,50,50,50,50,50,50,50,50, 10,10,10,10,10,10,10,10,10,10,]
       @temp_amount = 0 
       @invalid_amount = [1, 5, 2000, 5000, 10000]
       @bevarages = []
     end
     def total
       amount = 0
       monies.each do |money|
          amount += money 
       end
       amount - temp_amount
     end



     def receive(amount) 
        raise ArgumentError.new("そのお金(#{amount})は使えません") if invalid_amount.include?(amount)
        @temp_amount += amount 
        monies << amount
     end

     def add(add_bevarages)
       Array(add_bevarages).each do | add_b |
         if target = @bevarages.detect {|bevarage| bevarage.id == add_b.id }
            target.count += add_b.count
         else
            @bevarages << add_b
         end
       end
        
     end

     def avairable_bevarages
        return_array = []
        if target = @bevarages.detect {|bevarage| bevarage.amount <= temp_amount }
          return_array << target
        end
        return_array
     end


    def buy(bevarage_id)
      return false unless target = avairable_bevarages.detect {|bevarage| bevarage.id == bevarage_id}
      if target.count > 0
        target.count -= 1

        @temp_amount -= target.amount
      else
        return false
      end

      return true
    end


    def stock(bevarage_id)
      target = @bevarages.detect {|bevarage| bevarage.id == bevarage_id }
      return target.nil? ? 0 : target.count
    end

    def change
      return_amount = @temp_amount
      @temp_amount = 0
      return_amount
    end

  end

end



