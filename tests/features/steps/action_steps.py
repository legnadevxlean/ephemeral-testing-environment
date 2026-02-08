"""
Interaction and action step definitions.
"""
from behave import step, use_step_matcher
from common import get_locator

# Use regex matcher for more flexibility with empty strings
use_step_matcher("re")

@step(r'I click the "(?P<element_name>.*)" element')
def step_click_element(context, element_name):
    """Click on any element by its locator name."""
    locator = get_locator(context.current_page, element_name)
    context.current_page.click(locator)

@step(r'I type "(?P<text>.*)" in the "(?P<element_name>.*)" element')
def step_type_in_element(context, text, element_name):
    """Type text into any element. Handles empty strings correctly."""
    locator = get_locator(context.current_page, element_name)
    context.current_page.type_text(locator, text)
