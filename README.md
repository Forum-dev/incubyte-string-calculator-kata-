# String Calculator TDD Kata

Implementation for Incubyte assessment using TDD in Ruby. Uses RVM with gemset `incubyte_kata` for isolation. No Rails required—pure Ruby with RSpec. Includes full kata with all scenarios and edge cases. 100% test coverage via SimpleCov.

## Setup
- Install RVM: `curl -sSL https://get.rvm.io | bash -s stable`
- Install Ruby: `rvm install 3.2.2`
- Install gems: `bundle install`
- Run tests: `./bin/run_tests.sh`

## TDD Journey
- Step 1: Handle empty string
- Step 2: Single number
- Step 3: Two numbers
- Step 4: Arbitrary numbers
- Step 5: Newlines
- Step 6: Custom delimiters
- Step 7: Single negative
- Step 8: Multiple negatives
- Extra 9: Ignore >1000
- Refactor: Prep for multi-char
- Extra 10: Multi-char delimiters
- Extra 11: Multiple delimiters
- Comprehensive tests for edges
- Final polish with empty parts

## Why This Stands Out
- RVM gemset for environment isolation.
- Full kata implementation with edge cases (leading/trailing delimiters, empty parts).
- 100% test coverage (see coverage/index.html).
- Micro-commits show TDD evolution.
- Test runner script for ease.

## Coverage
![Coverage](coverage-screenshot.png)