@login
Feature: Login Functionality
  As a registered user
  I want to login to the application
  So that I can access my dashboard

  Background:
    Given I go to "LOGIN" page

  @sanity @QAT-3 @success
  Scenario: Successful login with valid credentials
    Given the "LOGIN" page is loaded
    When I type "test@legna.dev" in the "EMAIL_INPUT" element
    And I type "EphemeralTest@2026" in the "PASSWORD_INPUT" element
    And I click the "SUBMIT_BUTTON" element
    Then the "DASHBOARD" page is loaded
    And the element "SUCCESS_MESSAGE" is visible
    And the element "USER_EMAIL" contains text "test@legna.dev"

  @smoke @QAT-4 @failure
  Scenario: Login fails with invalid email
    When I type "wrong@email.com" in the "EMAIL_INPUT" element
    And I type "EphemeralTest@2026" in the "PASSWORD_INPUT" element
    And I click the "SUBMIT_BUTTON" element
    Then the element "SUBMIT_ERROR" text is equal to "Invalid email or password. Please try again."
    And the "LOGIN" page is loaded

  @smoke @QAT-5 @failure
  Scenario: Login fails with invalid password
    When I type "test@legna.dev" in the "EMAIL_INPUT" element
    And I type "WrongPassword123!" in the "PASSWORD_INPUT" element
    And I click the "SUBMIT_BUTTON" element
    Then the element "SUBMIT_ERROR" text is equal to "Invalid email or password. Please try again."
    And the "LOGIN" page is loaded

  @regression @failure @QAT-<test_id>
  Scenario Outline: Login fails with empty fields - <test_id>
    When I type "<email>" in the "EMAIL_INPUT" element
    And I type "<password>" in the "PASSWORD_INPUT" element
    And I click the "SUBMIT_BUTTON" element
    Then the "LOGIN" page is loaded

    Examples:
      | email          | password           | test_id |
      |                | EphemeralTest@2026 | QAT-6   |
      | test@legna.dev |                    | QAT-7   |
      |                |                    | QAT-8   |

  @regression @QAT-9 @navigation
  Scenario: Back to home link works
    When I click the "BACK_TO_HOME" element
    Then the "HOME" page is loaded

  @smoke @QAT-10 @navigation
  Scenario: Logout returns to login page
    Given I type "test@legna.dev" in the "EMAIL_INPUT" element
    And I type "EphemeralTest@2026" in the "PASSWORD_INPUT" element
    And I click the "SUBMIT_BUTTON" element
    And the "DASHBOARD" page is loaded
    When I click the "LOGOUT_BUTTON" element
    Then the "HOME" page is loaded
