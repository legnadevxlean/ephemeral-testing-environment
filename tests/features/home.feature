@home
Feature: Home Page
  As a visitor
  I want to see the home page
  So that I can understand what the application offers

  Background:
    Given I go to "HOME" page

  @sanity @QAT-1 @success
  Scenario: Home page loads successfully
    Given the "HOME" page is loaded
    Then the element "TITLE" text is equal to "Ephemeral QA Environment"
    And the element "WELCOME_MESSAGE" is visible

  @smoke @QAT-2 @navigation
  Scenario: Login link navigates to login page
    Given the "HOME" page is loaded
    When I click the "LOGIN_LINK" element
    Then the "LOGIN" page is loaded

