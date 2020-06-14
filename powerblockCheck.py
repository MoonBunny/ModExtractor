import sys
import time
from selenium import webdriver
from selenium.webdriver.firefox.options import Options

opts = Options()
opts.headless = True

driver = webdriver.Firefox(options=opts)  # Optional argument, if not specified will search path.
driver.get('https://powerblock.com/product/sport/');

try:
  time.sleep(5)

  type_element = driver.find_element_by_id('pa_dumbbell-type')
  all_options = type_element.find_elements_by_tag_name('option');
  for option in all_options:
    if option.text == "Expandable":
      option.click()
      break

  weight_element = driver.find_element_by_id('pa_weight')
  for option in weight_element.find_elements_by_tag_name('option'):
    if option.text == "5-90":
      option.click()
      break

  time.sleep(3)
  in_stock_element = driver.find_element_by_class_name('out-of-stock')
except Exception as e:
  print("item is stocked???")
  print(e)
  sys.exit(-1)

print("out of stock")
driver.quit()
sys.exit(0)
