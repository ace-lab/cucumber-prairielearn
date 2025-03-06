Feature: build your own URI

  Background:
    Given an instance of the question "two_part_uri"
    When I fill in the following responses:
      | field    | type     | response                |
      | protocol | dropdown | https                   |
      | host     | text     | abc.com                 |
      | path     | text     | /foo/                   |
      | param1   | text     | bar                     |
      | value1   | text     | 4                       |
      | uri      | text     | https://abc.com/foo/bar |
    And I submit my answer
    Then the score should be 0.85
    And the feedback should be "Not all params were included in the URI."
    
