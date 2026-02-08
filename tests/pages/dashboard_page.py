"""
Dashboard Page Object.
"""
from selenium.webdriver.common.by import By
from .base_page import BasePage


class DashboardPage(BasePage):
    """Page Object for the Dashboard page (post-login)."""
    
    ROUTE = "/dashboard"
    
    # Locators
    PAGE = (By.CSS_SELECTOR, "[data-testid='dashboard-page']")
    TITLE = (By.CSS_SELECTOR, "[data-testid='dashboard-title']")
    LOGOUT_BUTTON = (By.CSS_SELECTOR, "[data-testid='logout-button']")
    
    # Content
    WELCOME_CARD = (By.CSS_SELECTOR, "[data-testid='welcome-card']")
    WELCOME_MESSAGE = (By.CSS_SELECTOR, "[data-testid='welcome-message']")
    USER_EMAIL = (By.CSS_SELECTOR, "[data-testid='user-email']")
    SUCCESS_MESSAGE = (By.CSS_SELECTOR, "[data-testid='login-success-message']")
    
    def is_loaded(self) -> bool:
        """Check if the dashboard page is fully loaded."""
        return (
            self.is_element_visible(self.PAGE) and
            self.is_element_visible(self.WELCOME_CARD) and
            self.is_element_visible(self.USER_EMAIL) and
            self.is_element_visible(self.LOGOUT_BUTTON)
        )
