"""
Behave environment hooks - Setup and teardown for scenarios.
"""
import os
import allure
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager


def before_all(context):
    """
    Run once before all tests.
    Initialize configuration from environment or userdata.
    """
    context.base_url = os.getenv("BASE_URL", context.config.userdata.get("base_url", "http://localhost:3000"))
    context.headless = os.getenv("HEADLESS", context.config.userdata.get("headless", "false")).lower() == "true"
    
    context.driver = None


def before_scenario(context, scenario):
    """
    Run before each scenario.
    Create a fresh WebDriver instance.
    """
    options = Options()
    
    if context.headless:
        options.add_argument("--headless=new")

    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--disable-gpu")
    options.add_argument("--window-size=1920,1080")
    options.add_argument("--remote-allow-origins=*")
    options.add_argument("--disable-extensions")
    options.add_argument("--disable-infobars")
    
    service = Service(ChromeDriverManager().install())
    context.driver = webdriver.Chrome(service=service, options=options)
    context.driver.implicitly_wait(0)


def after_scenario(context, scenario):
    """
    Run after each scenario.
    Close the WebDriver and take screenshot on failure.
    """
    if context.driver:
        # Take screenshot on failure and attach to Allure
        if scenario.status == "failed":
            try:
                # Debug info to logs
                print(f"\n[DEBUG] Scenario '{scenario.name}' failed.")
                print(f"[DEBUG] Current URL: {context.driver.current_url}")
                
                # Capture browser console logs
                try:
                    browser_logs = context.driver.get_log('browser')
                    if browser_logs:
                        print("[DEBUG] Browser Console Logs:")
                        for entry in browser_logs:
                            print(f"  {entry['level']}: {entry['message']}")
                except Exception:
                    print("[DEBUG] Could not capture browser logs.")

                # Take screenshot
                allure.attach(
                    context.driver.get_screenshot_as_png(),
                    name=f"failure_{scenario.name}",
                    attachment_type=allure.attachment_type.PNG
                )
            except Exception as e:
                print(f"[DEBUG] Failed to capture debug info: {e}")
        
        context.driver.quit()
        context.driver = None


def after_all(context):
    """
    Run once after all tests.
    Cleanup any remaining resources.
    """
    if context.driver:
        context.driver.quit()
