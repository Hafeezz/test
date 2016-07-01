#Page Objects and workflows in the page 
 class HomePageObjects
  def product_category #get product category element
    @@element = $driver.find_element(:xpath,"//a[@href='http://store.demoqa.com/products-page/product-category/']")
  end

  def iphones #get iphone element
    @@element = $driver.find_element(:xpath,"//a[@href='http://store.demoqa.com/products-page/product-category/iphones/']")
  end

  def select_iphone #To select a Iphone
    $driver.action.click_and_hold(product_category).perform
    iphones.click
    sleep 4
  end
end