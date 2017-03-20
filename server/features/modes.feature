Feature: API, version 1
Background:
  Given API v1

Scenario: Modes index endpoint
Given the following modes:
|Name|URL                 |
|A   |http://example.org/a|
|B   |http://example.org/b|
When I hit the modes endpoint
And the response is 200
And the response is a HAL document
Then I can discover the mode count
And there are 2 modes
And I can see mode A
And I can see mode B
