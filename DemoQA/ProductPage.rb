#Page Objects and workflows in the page 
class ProductPageObjects 
  def add_black_iphone  #get black iphone element
  @@element = $driver.find_element(:xpath,"//h2/a[@href= 'http://store.demoqa.com/products-page/product-category/iphones/apple-iphone-4s-16gb-sim-free-black/']")
  end
  
    def add_to_cart  #get add to cart button
    @@element = $driver.find_element(:xpath,"//input[@value= 'Add To Cart']")
  end

  def go_to_checkout  #get go to checkout button
    @@element = $driver.find_element(:xpath,"//a[@class= 'go_to_checkout']")
  end
  
  def add_phone_to_cart         #To add a black iphone to cart
    puts add_black_iphone.text
    add_black_iphone.click
    sleep 2
    add_to_cart.click
    sleep 4
    go_to_checkout.click
    sleep 3
  end
end