Feature: Loading modes into the repository
Scenario: All modes

Given the following mode list:
| name | url                     |
| ruby | http://example.org/     |
| bash | http://example.org/bash |

When I load the modes
Then There are 2 modes
