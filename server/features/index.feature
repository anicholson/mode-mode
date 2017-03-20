Feature: API, version 1
Background:
  Given API v1

Scenario: Discoverable API features
When I hit the root of the API
And the response is 200
And I can discover a modes endpoint
