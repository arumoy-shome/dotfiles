function ls -d "List contents of directory"
  # do not execute if command substitution
  status --is-command-sub; and return
  command ls -FG $argv
end
