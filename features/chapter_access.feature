Feature: Chapter Access
  Student can access chapters only in a certain order.

  @ok
  Scenario: Access of description of a chapter
    Given a user is authenticated
      And he is on the chapter page
    When he visit a chapter
    Then he can see the description of these chapter

  @ok
  Scenario: Access on missions of a chapter
    Given a user is authenticated
      And he is on some chapter description page
    When he visit the realisation of these chapter
    Then he can see the missions of this chapter

  @wip
  Scenario: Save a program
    Given a user edit a program
    When he save the modified program
    Then he can reload the program without loosing anything

  @wip
  Scenario: View only the already successed and one next chapters
    Given a user is authenticated
      And he have already complet some chapters
    When he is on the chapter page
    Then he should see already successed chapters
      And he should see the next chapter to try
      But he can't see other chapters

  @wip
  Scenario: View only the first chapter for new user
    Given a new user is authenticated
    When he is on the chapter page
    Then he should see only the first chapter

  @presentation @current
  Scenario: Creation of a new chapter
    Given a professor is authenticated
      And he is on the chapter page
    When he access to the page for the chapter creation
    Then he can fill in information of the new chapter
      And he can create the program of the chapter
