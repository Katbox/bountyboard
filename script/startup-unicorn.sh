#!/bin/bash

bounty_board_root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.."
cd "${bounty_board_root}"

# start unicorn as a daemon
bundle exec unicorn -E production -c config/unicorn.rb -D

