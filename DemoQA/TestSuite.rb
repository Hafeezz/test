require 'rubygems'
require 'selenium-webdriver'
require 'rspec'
require 'rspec/autorun'
require 'rspec/expectations'
require 'pry'

require_relative 'C:\Users\Abdul Hafeez\Documents\Aptana Studio 3 Workspace\DemoQA\MyAccountPage.rb'
require_relative 'C:\Users\Abdul Hafeez\Documents\Aptana Studio 3 Workspace\DemoQA\HomePage.rb'
require_relative 'C:\Users\Abdul Hafeez\Documents\Aptana Studio 3 Workspace\DemoQA\CheckoutPage.rb'
require_relative 'C:\Users\Abdul Hafeez\Documents\Aptana Studio 3 Workspace\DemoQA\ProductPage.rb'

describe "testsuite" do
  $new_address = "6400 ohio dr, Apt #100"

  before(:all) do  #initiate web driver and launch test website
    $driver = Selenium::WebDriver.for :chrome
    $driver.navigate.to "http://store.demoqa.com"
  end

  after(:all) do   #Quit web driver
    $driver.quit
    puts "--Web Driver quit successfully--"
  end

  it "Add a product and purchase" do 
    MyAccountPageObjects.new.login_with_existing_user     #Login an existing user
    
    HomePageObjects.new.select_iphone                     #Select Iphone from dropdown
    
    ProductPageObjects.new.add_black_iphone               #Add a black iphone 4s     
    
    ProductPageObjects.new.add_phone_to_cart              #Add phone to cart  

    CheckoutPageObjects.new.verify_price_in_cart          #Price validations and change address for next test 

    CheckoutPageObjects.new.purchase_phone                #Purchase the phone
  end

  it "Logout user and verify the address is updated" do
    CheckoutPageObjects.new.logout_user                   #Logout the user  

    MyAccountPageObjects.new.login_with_existing_user     #Login again
    
    HomePageObjects.new.select_iphone                     #Add an item and go to checkout page
    
    ProductPageObjects.new.add_black_iphone
    
    ProductPageObjects.new.add_phone_to_cart
    
    CheckoutPageObjects.new.continue_button.click
    sleep 3
    
    addr = CheckoutPageObjects.new.address.text            #Verify address gotten and changed in earlier test 
    if addr == $new_address
      puts "--Address is updated--"
    else
      puts "--Address is not updated--"
    end
  end

  it "Remove all items from cart and verify empty cart message" do
    CheckoutPageObjects.new.empty_cart                      #Empty cart and verify text
  end
end

