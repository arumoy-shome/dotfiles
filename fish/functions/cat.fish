function cat
  if command -sq bat
    bat $argv
  else
    cat $argv
  end
end
