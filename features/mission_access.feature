Feature: Mission Access
  Student can access missions only in a certain order.

  @ok
  Scenario: Access of description of a mission
    Given a user is authenticated
      And he is on the mission page
    When he visit a mission
    Then he can see the description of these mission

  @ok @presentation
  Scenario: Access on snap to solve a mission
    Given a user is authenticated
      And he is on some mission description page
    When he visit the realisation of these mission
    Then he can see the snap
      And he can see the begining of these mission

  @wip
  Scenario: Save a program
    Given a user edit a program
    When he save the modified program
    Then he can reload the program without loosing anything

  @wip
  Scenario: View only the already successed and one next missions
    Given a user is authenticated
      And he have already complet some missions
    When he is on the mission page
    Then he should see already successed missions
      And he should see the next mission to try
      But he can't see other missions

  @wip
  Scenario: View only the first mission for new user
    Given a new user is authenticated
    When he is on the mission page
    Then he should see only the first mission

  @presentation @current
  Scenario: Creation of a new mission
    Given a professor is authenticated
      And he is on the mission page
    When he access to the page for the mission creation
    Then he can fill in information of the new mission
      And he can create the program of the mission
