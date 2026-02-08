"""
Login Page Object.
"""
from selenium.webdriver.common.by import By
from .base_page import BasePage


class LoginPage(BasePage):
    """Page Object for the Login page."""
    
    ROUTE = "/login"
    
    # Locators
    PAGE = (By.CSS_SELECTOR, "[data-testid='login-page']")
    TITLE = (By.CSS_SELECTOR, "[data-testid='login-title']")
    BACK_TO_HOME = (By.CSS_SELECTOR, "[data-testid='back-to-home']")
    LOGIN_FORM = (By.CSS_SELECTOR, "[data-testid='login-form']")
    
    # Form inputs
    EMAIL_INPUT = (By.CSS_SELECTOR, "[data-testid='email-input']")
    PASSWORD_INPUT = (By.CSS_SELECTOR, "[data-testid='password-input']")
    SUBMIT_BUTTON = (By.CSS_SELECTOR, "[data-testid='submit-button']")
    
    # Error messages
    SUBMIT_ERROR = (By.CSS_SELECTOR, "[data-testid='submit-error']")
    EMAIL_ERROR = (By.CSS_SELECTOR, "[data-testid='email-error']")
    PASSWORD_ERROR = (By.CSS_SELECTOR, "[data-testid='password-error']")
    
    # Demo credentials display
    DEMO_CREDENTIALS = (By.CSS_SELECTOR, "[data-testid='demo-credentials']")
    
    def is_loaded(self) -> bool:
        """Check if the login page is fully loaded."""
        return (
            self.is_element_visible(self.PAGE) and
            self.is_element_visible(self.LOGIN_FORM) and
            self.is_element_visible(self.EMAIL_INPUT) and
            self.is_element_visible(self.PASSWORD_INPUT) and
            self.is_element_visible(self.SUBMIT_BUTTON)
        )
    
    def login(self, email: str, password: str):
        """Perform complete login action."""
        self.type_text(self.EMAIL_INPUT, email)
        self.type_text(self.PASSWORD_INPUT, password)
        self.click(self.SUBMIT_BUTTON)
