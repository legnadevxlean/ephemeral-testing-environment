# SKIPPED (already covered): None — all ACs require new test coverage
# US Type: Frontend E2E
# Generated: 2026-04-16 | Source: Azure Work Item #35

@azure.QAGTM-51
@app
@us-35
@authentication
Feature: US-35 Authentication and Platform Access

  # ─────────────────────────── SCENARIO 1 ───────────────────────────
  @azure.QAGTM-52
  @e2e @azure.cv.1.0.0
  @sanity @azure.link.parent_test_plan.QAGTM-18 @azure.link.parent_test_plan.QAGTM-20 @azure.link.parent_test_plan.QAGTM-22
  Scenario: Visitor navigates from Home to Login and authenticates successfully
    # Covers AC1 - Home page loads with expected content
    Given I go to "home" page
    Then the "home" page is loaded
    And the element "title" is visible
    And the element "welcome_message" is visible
    And the element "login_link" is visible
    # Covers AC2 - Navigation Home → Login
    When I click the "login_link" element
    Then the "login" page is loaded
    # Covers AC3 - Login form presents all required fields
    And the element "email_input" is visible
    And the element "password_input" is visible
    And the element "submit_button" is visible
    # Covers AC4 - Successful login redirects to Dashboard
    When I type "test@legna.dev" in the "email_input" element
    And I type "EphemeralTest@2026" in the "password_input" element
    And I click the "submit_button" element
    Then the "dashboard" page is loaded
    And the element "success_message" is visible
    And the element "user_email" contains text "test@legna.dev"

  # ─────────────────────────── SCENARIO 2 ───────────────────────────
  @azure.QAGTM-53
  @e2e @azure.cv.1.0.0
  @smoke @azure.link.parent_test_plan.QAGTM-20 @azure.link.parent_test_plan.QAGTM-22
  @azure.ac.US-35#AC5,AC6,AC10
  Scenario: User attempts login with invalid credentials and navigates back to Home
    # Covers AC5 - Login rejected with invalid email
    Given I go to "login" page
    Then the "login" page is loaded
    When I type "wrong@email.com" in the "email_input" element
    And I type "EphemeralTest@2026" in the "password_input" element
    And I click the "submit_button" element
    Then the "login" page is loaded
    And the element "submit_error" is visible
    And the element "submit_error" text is equal to "Invalid email or password. Please try again."
    # Covers AC6 - Login rejected with invalid password
    When I type "test@legna.dev" in the "email_input" element
    And I type "WrongPassword123!" in the "password_input" element
    And I click the "submit_button" element
    Then the "login" page is loaded
    And the element "submit_error" is visible
    And the element "submit_error" text is equal to "Invalid email or password. Please try again."
    # Covers AC10 - Navigation Login → Home
    When I click the "back_to_home" element
    Then the "home" page is loaded

  # ─────────────────────────── SCENARIO 3 ───────────────────────────
  @azure.QAGTM-54
  @e2e @azure.cv.1.0.0
  @regression @azure.link.parent_test_plan.QAGTM-22
  @azure.ac.US-35#AC7
  Scenario: Login rejected when email field is empty
    Given I go to "login" page
    Then the "login" page is loaded
    When I type "EphemeralTest@2026" in the "password_input" element
    And I click the "submit_button" element
    Then the "login" page is loaded
    And the element "email_error" is visible

  # ─────────────────────────── SCENARIO 4 ───────────────────────────
  @azure.QAGTM-55
  @e2e @azure.cv.1.0.0
  @regression @azure.link.parent_test_plan.QAGTM-22
  @azure.ac.US-35#AC8
  Scenario: Login rejected when password field is empty
    Given I go to "login" page
    Then the "login" page is loaded
    When I type "test@legna.dev" in the "email_input" element
    And I click the "submit_button" element
    Then the "login" page is loaded
    And the element "password_error" is visible

  # ─────────────────────────── SCENARIO 5 ───────────────────────────
  @azure.QAGTM-56
  @e2e @azure.cv.1.0.0
  @regression @azure.link.parent_test_plan.QAGTM-22
  @azure.ac.US-35#AC9
  Scenario: Login rejected when both email and password fields are empty
    Given I go to "login" page
    Then the "login" page is loaded
    When I click the "submit_button" element
    Then the "login" page is loaded
    And the element "email_error" is visible
    And the element "password_error" is visible
