#!/bin/bash

# Test 1: Mixing --env-file and --env-file-if-exists (BUG)
echo "=== Test 1: --env-file + --env-file-if-exists ==="
echo "Without --watch:"
for v in 24.11 24.12 24.13 25; do
  mise exec node@$v -- node --env-file=.env --env-file-if-exists=.env.local test.js
done

echo ""
echo "With --watch:"
for v in 24.11 24.12 24.13 25; do
  mise exec node@$v -- node --watch --env-file=.env --env-file-if-exists=.env.local test.js &
  sleep 0.5
  kill $! 2>/dev/null
  wait $! 2>/dev/null
done

# Test 2: Using only --env-file (works correctly)
echo ""
echo "=== Test 2: --env-file + --env-file (works correctly) ==="
echo "Without --watch:"
for v in 24.11 24.12 24.13 25; do
  mise exec node@$v -- node --env-file=.env --env-file=.env.local test.js
done

echo ""
echo "With --watch:"
for v in 24.11 24.12 24.13 25; do
  mise exec node@$v -- node --watch --env-file=.env --env-file=.env.local test.js &
  sleep 0.5
  kill $! 2>/dev/null
  wait $! 2>/dev/null
done

# Test 3: Using only --env-file-if-exists (works correctly)
echo ""
echo "=== Test 3: --env-file-if-exists + --env-file-if-exists (works correctly) ==="
echo "Without --watch:"
for v in 24.11 24.12 24.13 25; do
  mise exec node@$v -- node --env-file-if-exists=.env --env-file-if-exists=.env.local test.js
done

echo ""
echo "With --watch:"
for v in 24.11 24.12 24.13 25; do
  mise exec node@$v -- node --watch --env-file-if-exists=.env --env-file-if-exists=.env.local test.js &
  sleep 0.5
  kill $! 2>/dev/null
  wait $! 2>/dev/null
done
