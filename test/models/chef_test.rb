require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname: "Tania", email: "Tania@example.com")
  end
  
  test "chef should be valid" do
    assert @chef.valid?  
  end
  
  test "chefname should be present" do
    @chef.chefname = " "
    assert_not @chef.valid?
  end

  test "chefname should not be too long" do
    @chef.chefname = "a" * 41
    assert_not @chef.valid?
  end
  
  test "chefname should not be too short" do 
    @chef.chefname = "a" * 2
    assert_not @chef.valid?
  end
  
  test "email should be present" do
    @chef.email = " "
    assert_not @chef.valid?
  end
  
  test "email should be within bounds" do
    @chef.email = "a" * 101 + "example.com"
    assert_not @chef.valid?
  end
  
  test "email address should be unique" do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
  end

  test "email validation should accept valid addresses" do
    #%w will break into array of elements
    valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.org user@example.com  first.last@eem.au laura+joe@monk.cm]
    valid_addresses.each do |va|
      @chef.email = va
      assert @chef.valid?, "#{va.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_ae_eee.org user.name@example. eee@i_am_.com foo@ee+aar.com]
    invalid_addresses.each do |iva|
      @chef.email = iva
      assert_not @chef.valid?, "#{iva.inspect} should be invalid"
    end
  end

end