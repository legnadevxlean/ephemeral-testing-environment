"""
Navigation related step definitions.
"""
from behave import step
from common import PAGE_CLASSES

@step('I go to "{page_name}" page')
def step_navigate_to_page(context, page_name):
    """Explicitly navigate to a page by name and verify it's loaded."""
    page_class = PAGE_CLASSES.get(page_name.lower())
    if not page_class:
        raise ValueError(f"Unknown page: {page_name}")
    
    page_attr = f'{page_name.lower()}_page'
    page = page_class(context.driver, context.base_url)
    setattr(context, page_attr, page)
    
    page.navigate()
    assert page.is_loaded(), f"{page_name} page not loaded after navigation"
    context.current_page = page


@step('the "{page_name}" page is loaded')
def step_dynamic_page_loaded(context, page_name):
    """Verify that a specific page is currently loaded."""
    page_class = PAGE_CLASSES.get(page_name.lower())
    if not page_class:
        raise ValueError(f"Unknown page: {page_name}")
    
    page_attr = f'{page_name.lower()}_page'
    page = getattr(context, page_attr, None)
    
    if not page:
        page = page_class(context.driver, context.base_url)
        setattr(context, page_attr, page)
    
    assert page.is_loaded(), f"{page_name} page is not loaded"
    context.current_page = page
