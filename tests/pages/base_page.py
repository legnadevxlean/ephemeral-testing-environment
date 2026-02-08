"""
Base Page Object class with common functionality.
"""
from selenium.webdriver.remote.webdriver import WebDriver
from selenium.webdriver.remote.webelement import WebElement
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException
import allure


class BasePage:
    """Base class for all page objects."""
    
    ROUTE = None  # Override in subclass (e.g., "/", "/login")
    
    def __init__(self, driver: WebDriver, base_url: str):
        self.driver = driver
        self.base_url = base_url
        self.timeout = 20
    
    def navigate(self, path: str = None):
        """Navigate to the page's route or a specific path."""
        target_path = path if path is not None else getattr(self, 'ROUTE', '')
        url = f"{self.base_url}{target_path}"
        with allure.step(f"Navigate to {url}"):
            self.driver.get(url)
    
    def find_element(self, locator: tuple) -> WebElement:
        """Find an element with explicit wait."""
        return WebDriverWait(self.driver, self.timeout).until(
            EC.presence_of_element_located(locator)
        )
    
    def find_clickable_element(self, locator: tuple) -> WebElement:
        """Find a clickable element with explicit wait."""
        return WebDriverWait(self.driver, self.timeout).until(
            EC.element_to_be_clickable(locator)
        )
    
    def find_visible_element(self, locator: tuple) -> WebElement:
        """Find a visible element with explicit wait."""
        return WebDriverWait(self.driver, self.timeout).until(
            EC.visibility_of_element_located(locator)
        )
    
    def is_element_visible(self, locator: tuple, timeout: int = None) -> bool:
        """Check if an element is visible."""
        try:
            WebDriverWait(self.driver, timeout or self.timeout).until(
                EC.visibility_of_element_located(locator)
            )
            return True
        except TimeoutException:
            return False
    
    def get_text(self, locator: tuple) -> str:
        """Get text from an element."""
        return self.find_visible_element(locator).text
    
    def click(self, locator: tuple):
        """Click on an element."""
        element = self.find_clickable_element(locator)
        with allure.step(f"Click on element {locator}"):
            element.click()
    
    def type_text(self, locator: tuple, text: str):
        """Type text into an input field."""
        element = self.find_visible_element(locator)
        with allure.step(f"Type '{text}' into {locator}"):
            element.clear()
            element.send_keys(text)
    
    def get_current_url(self) -> str:
        """Get the current URL."""
        return self.driver.current_url
    
    def get_title(self) -> str:
        """Get the page title."""
        return self.driver.title
    
    def take_screenshot(self, name: str):
        """Take a screenshot and attach to Allure report."""
        allure.attach(
            self.driver.get_screenshot_as_png(),
            name=name,
            attachment_type=allure.attachment_type.PNG
        )
