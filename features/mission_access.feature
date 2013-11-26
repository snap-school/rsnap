Feature: Mission Access
  Student can access missions only in a certain order
  and after have try previous missions in this order.

  @wip
  Scenario: View only the first mission for new user
    Given a new user is authenticated
    When he visit the mission page
    Then he should see only the first mission

  @wip
  Scenario: Access of descritpion and ide of mission
    Given a user is authenticated
      And he visit the mission page
    When he click on some mission
    Then he can see the description of these mission
      And he can access to the ide of them

  @wip
  Scenario: View only the already successed and one next missions
    Given a user is authenticated
      And he have already complet some missions
    When he visit the mission page
    Then he should see already successed missions
      And he should see the next mission to try
      But he can't see other missions
