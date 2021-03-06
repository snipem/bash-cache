#!/usr/bin/env bats
# run: make test

setup () {
    # Load utils for better testing
    load '/usr/local/lib/bats-support/load.bash'
    load '/usr/local/lib/bats-assert/load.bash'

    rm -rv "$TMPDIR/bash_cache" 2&>/dev/null || true
}


@test "normal-run" {

  date_before=$(./bash-cache date +"%s")
  sleep 2s
  run ./bash-cache date +"%s"
  # Output matches the current output
  echo $date_before | assert_output
  assert_success
}

@test "with-timeout-use-cache" {

  date_before=$(./bash-cache date +"%s")

  # Sleep for 2 seconds, expect the second command to be _not_ cached
  sleep 2s
  run ./bash-cache -t 1s date +"%s"

  assert_output --regexp '^[0-9]+$'
  assert_output --partial $(echo "$date_before" | cut -c -3) # Expect the first three digits to be the same

  echo $date_before | refute_output # Output must not match
  assert_success
}

@test "with-timeout-do-not-use-cache" {

  date_before=$(./bash-cache date +"%s")

  # Sleep for 2 seconds, expect the second command to be cached
  sleep 2s
  run ./bash-cache -t 1h date +"%s"

  echo $date_before | assert_output
  assert_success
}

@test "exit-code" {

  run ./bash-cache exit 2
  assert_failure 2

  # Run again, exit code should be cached
  run ./bash-cache exit 2
  assert_failure 2
}

@test "cache-stderr" {
   ./bash-cache ">&2 echo error" 2>&1 | grep error
   ./bash-cache ">&2 echo error" 2>&1 | grep error
}
