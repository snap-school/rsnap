Feature: Signing in
  In order to track progression of student, users must be logged.

  Scenario: Unsuccessful signin
    Given a user is not authenticated
      And a user visits the signin page
    When he submits invalid signin information
    Then he should see an error message

  Scenario: Successful signin
    Given a user is not authenticated
      And a user visits the signin page
      And the user has an account
    When the user submits valid signin information
    Then he should see her profile page
      And he should see a signout link
