#Page Objects and workflows in the page 
class CheckoutPageObjects 
  def actual_price #get actual price
    @@element = $driver.find_element(:xpath, "//span[@class='pricedisplay']")
  end

  def continue_button #get continue button
    @@element = $driver.find_element(:xpath,"//a/span[text()= 'Continue']")
  end

  def oops_message #get empty cart message
    @@element = $driver.find_element(:xpath,"//div[@class='entry-content']")
  end

  def address #get address
    @@element = $driver.find_element(:xpath,"//*[@id='wpsc_checkout_form_4']")
  end

  def total_price #get total price
    @@element = $driver.find_element(:xpath,"//*[@id='checkout_total']/span").attribute("innerHTML")
  end

  def total_shipping #get shipping cost
    @@element = $driver.find_element(:xpath,"//*[@id='wpsc_shopping_cart_container']/form/div[3]/table/tbody/tr[2]/td[2]/span/span").attribute("innerHTML")
  end

  def item_cost #get item's cost
    @@element = $driver.find_element(:xpath,"//*[@id='wpsc_shopping_cart_container']/form/div[3]/table/tbody/tr[3]/td[2]/span/span").attribute("innerHTML")
  end

  def purchase_button #get purchase button
    @@element = $driver.find_element(:xpath,"//input[@value='Purchase']")
  end

  def remove_button #get remove button
    @@element =  $driver.find_element(:xpath,"//input[@value='Remove']")
  end

  def logout_button #get logout button
    @@element =  $driver.find_element(:xpath,"//div[@id='account_logout']/a")
  end
  
    def go_back_button #get go back button
    @@element =  $driver.find_element(:xpath,"//span[text()='Go Back']") 
  end
  

  def verify_price_in_cart   #To verify actual price from cart & checkout page and verify total price calculation
    sleep 2
    a_price = actual_price.text
    a_price = a_price.gsub('$', '').to_i.round
    puts "Actual Price is: "+ a_price.to_s
    continue_button.click
    sleep 3

    i_cost = item_cost
    i_cost = i_cost.gsub('$', '').to_i.round
    puts "Item Cost is: "+ i_cost.to_s

    shipping = total_shipping
    shipping = shipping.gsub('$', '').to_i.round
    puts "shipping Price is: "+ shipping.to_s

    t_price = total_price
    t_price = t_price.gsub('$', '').to_i.round
    puts "Total Price inclusive is: "+ t_price.to_s

    if (a_price).eql?(i_cost)
      puts"--Price of the phone is correct--"
    else
      puts "--Price of the phone is incorrect--"
    end

    total_cost = i_cost + shipping
    puts "Total price: " + total_cost.to_s

    if (total_cost).eql?(t_price)
      puts"--Total Price of the phone is correct--"
    else
      puts "--Total Prices is incorrect--"
    end
    change_address
  end

  def change_address    #To change address during purchase
    address.clear
    sleep 2
    address.send_keys($new_address)
    puts "--Address Changed successfully--"
  end

  def purchase_phone    #To purchase a item
    purchase_button.click
    puts "--Purchase Done Successfully--"
    sleep 5
  end

  def logout_user       #To logout a user
    logout_button.click
    puts "--User logged out successfully--"
    sleep 5
  end
  
  def empty_cart        #To empty and cart and verify message in it
    go_back_button.click
    sleep 2
    remove_button.click
    sleep 2
    puts oops_message.text
  end    
end