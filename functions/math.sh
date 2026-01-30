#!/bin/sh

# Function: math
# Description: Do math
# Usage: math [arguments]
# Alias: m

_math() {
  if [ "$#" -eq 0 ]; then
    printf "%s\n" "Usage: math <expression>" >&2
    return 2
  fi

  python -c '
import sys, numbers
expr = " ".join(sys.argv[1:])
val = eval(expr)
try:
    if isinstance(val, bool):
        out = str(val)
    elif isinstance(val, numbers.Integral):
        out = f"{int(val):,}"
    elif isinstance(val, numbers.Real):
        out = f"{float(val):,}"
    else:
        out = str(val)
except Exception:
    out = str(val)
print(out)
' "$@"
}

# In zsh, allow `math 3 * (4 + 1)` without needing escapes/quotes.
if [ -n "${ZSH_VERSION-}" ]; then
  alias math="noglob _math"
  alias m="noglob _math"
else
  alias math="_math"
  alias m="_math"
fi
