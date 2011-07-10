# encoding: UTF-8

require 'tddbc/vending_machine'
require 'tddbc/bevarage'

describe Tddbc::VendingMachine do
  it 'VendingMachineがnewできること' do
    expect {
      Tddbc::VendingMachine.new
    }.to_not raise_error
  end

  it '100円いれる' do
    vm = Tddbc::VendingMachine.new
    vm.receive(100)
    vm.temp_amount.should be(100)
  end

  it '1円を入れると例外が出るよ' do
      vm = Tddbc::VendingMachine.new
    expect {
      vm.receive(1)
    }.to raise_error(ArgumentError)
    
  end
  it "100円と50円が投入されたとき合計金額１５０円が算出でき" do
      vm = Tddbc::VendingMachine.new
      vm.receive(100)
      vm.receive(50)
      vm.temp_amount.should be 150

  end

  it "コーラ５本が追加されると、ざいごとして保持される" do

      vm = Tddbc::VendingMachine.new
      cola  = Tddbc::Bevarage.new(1, 120,"cola")
      cola.count = 5
      vm.add( cola )
      vm.bevarages.size.should be(1)
      vm.bevarages.first.id.should be(1)
      vm.bevarages.first.count.should be(5)

      soda  = Tddbc::Bevarage.new(2, 120,"soda")
      soda.count = 3
      vm.add( soda )

      vm.bevarages.size.should be(2)
      vm.bevarages[1].id.should be(2)
      vm.bevarages[1].count.should be(3)
  end


  it "120円いれたら、コーラだけが取得できる" do
      vm = Tddbc::VendingMachine.new
      cola  = Tddbc::Bevarage.new(1, 120,"cola")
      cola.count = 5
      vm.add( cola )
      nacchan  = Tddbc::Bevarage.new(2, 150,"なっちゃん")
      nacchan.count = 5
      vm.add( nacchan )

      vm.receive(120)

      vm.avairable_bevarages.detect {|bevarage| bevarage.id == 1}.id.should  be 1
      vm.avairable_bevarages.detect {|bevarage| bevarage.id == 2}.should be_nil
  end

  it "コーラのIDを指定して購入するとコーラの在庫が減る" do
      vm = Tddbc::VendingMachine.new
      cola  = Tddbc::Bevarage.new(1, 120,"cola")
      cola.count = 5

      original = vm.total
      vm.add( cola )
      vm.receive(150)

      vm.buy(1).should be_true
      vm.temp_amount.should be(30)
      (vm.total - original).should be(120)
  end

  it 'コーラのIDを指定すると、コーラの在庫数が取得できる' do
      vm = Tddbc::VendingMachine.new
      cola  = Tddbc::Bevarage.new(1, 120,"cola")
      cola.count = 5

      original = vm.total
      vm.add( cola )
      vm.stock(1).should be 5

      vm.receive(150)

      vm.buy(1).should be_true
      vm.stock(1).should be 4

      vm.stock(2).should be 0
  end

  it '初期状態で千円さつ５枚、各硬貨１０枚ずつ保持している' do
      vm = Tddbc::VendingMachine.new
      vm.monies.select{|m| m == 1000}.size.should be 5
      vm.monies.select{|m| m == 500}.size.should be 10 
      vm.monies.select{|m| m == 100}.size.should be 10 
      vm.monies.select{|m| m == 50}.size.should be 10 
      vm.monies.select{|m| m == 10}.size.should be 10 
  end
end

