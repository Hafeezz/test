#Page Objects and workflows in the page 
class MyAccountPageObjects
  def my_account_link #get My Account link
    @@element= $driver.find_element(:xpath, "//a[@title='My Account']")
  end

  def username #get username element 
    @@element= $driver.find_element(:xpath,"//input[@id='log']")
  end

  def password  #get password element
    @@element = $driver.find_element(:xpath,"//input[@id='pwd']")
  end

  def login_button  #get login button
    @@element = $driver.find_element(:xpath,"//input[@id='login']")
  end

  def  login_with_existing_user  #To login a user with credentials
    my_account_link.click
    sleep 2
    username.send_keys "hafeez"
    password.send_keys "hafeez2U!!"
    login_button.click
    sleep 2
  end
end

