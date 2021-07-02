#!/usr/bin/env python3

import sys

from selenium import webdriver
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By

firefox_opts = webdriver.FirefoxOptions()
firefox_opts.headless = True
firefox_opts.add_argument(f"--height={sys.argv[1]}")
firefox_opts.add_argument(f"--width={sys.argv[2]}")

driver = webdriver.Firefox(
    firefox_binary=sys.argv[3], options=firefox_opts,
)

driver.get(sys.argv[4])

driver.find_element_by_xpath("//span[contains(text(), 'Souhlasím')]").click()

timeout = 12
try:
    element_present = EC.presence_of_element_located((By.CLASS_NAME, 'section-layout'))
    WebDriverWait(driver, timeout).until(element_present)
except TimeoutException:
    print("Timed out waiting for page to load")

driver.save_screenshot(sys.argv[5])
driver.quit()
