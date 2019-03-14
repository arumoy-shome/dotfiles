function diff -d "use kitten diff if available else fallback to diff"
  if command -sq kitty
    kitty +kitten diff $argv
  else
    diff $argv
  end
end
