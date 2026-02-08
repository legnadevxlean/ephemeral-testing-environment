"""
Common utilities for step definitions.
"""
import sys
import os
import importlib
import inspect
from pages.base_page import BasePage

# Add parent directory to path for imports
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(__file__))))

def load_pages():
    """Scan pages/ folder and register all *Page classes."""
    pages_dir = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(__file__))), 'pages')
    page_classes = {}
    
    for filename in os.listdir(pages_dir):
        if filename.endswith('_page.py') and not filename.startswith('base'):
            module_name = filename[:-3]  # Remove .py
            module = importlib.import_module(f'pages.{module_name}')
            
            for name, obj in inspect.getmembers(module, inspect.isclass):
                if name.endswith('Page') and issubclass(obj, BasePage) and obj is not BasePage:
                    # home_page.py -> HomePage -> 'home'
                    page_key = name.replace('Page', '').lower()
                    page_classes[page_key] = obj
    
    return page_classes

# Auto-discover pages at import time
PAGE_CLASSES = load_pages()

def get_locator(page, element_name: str) -> tuple:
    """Get locator from page class by element name (e.g., 'TITLE' -> page.TITLE)."""
    locator_name = element_name.upper().replace(' ', '_')
    locator = getattr(page.__class__, locator_name, None)
    if not locator:
        raise ValueError(f"Element '{element_name}' not found in {page.__class__.__name__}")
    return locator
