Feature: Mission Access
  Student can access missions only in a certain order
  and after have try previous missions in this order.

  @ok
  Scenario: Access of description of a mission
    Given a user is authenticated
      And he is on the mission page
    When he visit a mission
    Then he can see the description of these mission

  @wip
  Scenario: Access on ide to solve a mission
    Given a user is authenticated
      And he is on some mission page
    When he visit the realisation of these mission
    Then he can see the ide
      And he can see the begining of these mission

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
