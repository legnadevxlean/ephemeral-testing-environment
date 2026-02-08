"""
Home Page Object.
"""
from selenium.webdriver.common.by import By
from .base_page import BasePage


class HomePage(BasePage):
    """Page Object for the Home page."""
    
    ROUTE = "/"
    
    # Locators
    PAGE = (By.CSS_SELECTOR, "[data-testid='home-page']")
    TITLE = (By.CSS_SELECTOR, "[data-testid='home-title']")
    WELCOME_MESSAGE = (By.CSS_SELECTOR, "[data-testid='welcome-message']")
    LOGIN_LINK = (By.CSS_SELECTOR, "[data-testid='login-link']")
    FOOTER = (By.CSS_SELECTOR, "[data-testid='footer']")
    FEATURE_EPHEMERAL = (By.CSS_SELECTOR, "[data-testid='feature-ephemeral']")
    FEATURE_REPORTS = (By.CSS_SELECTOR, "[data-testid='feature-reports']")
    
    def is_loaded(self) -> bool:
        """Check if the home page is fully loaded."""
        return (
            self.is_element_visible(self.PAGE) and
            self.is_element_visible(self.FOOTER) and
            self.is_element_visible(self.FEATURE_EPHEMERAL) and
            self.is_element_visible(self.FEATURE_REPORTS)
        )
