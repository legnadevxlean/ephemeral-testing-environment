"""
Element verification step definitions.
"""
from behave import step, use_step_matcher
from common import get_locator

# Use regex matcher for more flexibility with empty strings
use_step_matcher("re")

@step(r'the element "(?P<element_name>.*)" contains text "(?P<expected_text>.*)"')
def step_element_contains_text(context, element_name, expected_text):
    """Verify element text contains expected value."""
    locator = get_locator(context.current_page, element_name)
    actual_text = context.current_page.get_text(locator)
    assert expected_text in actual_text, f"Expected '{expected_text}' in '{actual_text}'"

@step(r'the element "(?P<element_name>.*)" text is equal to "(?P<expected_text>.*)"')
def step_element_equals_text(context, element_name, expected_text):
    """Verify element text equals expected value."""
    locator = get_locator(context.current_page, element_name)
    actual_text = context.current_page.get_text(locator)
    assert actual_text == expected_text, f"Expected '{expected_text}', got '{actual_text}'"

@step(r'the element "(?P<element_name>.*)" is visible')
def step_element_is_visible(context, element_name):
    """Verify element is visible."""
    locator = get_locator(context.current_page, element_name)
    assert context.current_page.is_element_visible(locator), f"Element '{element_name}' not visible"
