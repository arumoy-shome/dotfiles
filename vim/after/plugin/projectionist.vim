let g:projectionist_heuristics = {
  \ "after/|autoload/|plugin/|ftplugin/|ftdetect/": {
  \   "plugin/*.vim": {
  \     "type": "plug",
  \     "alternate": ["autoload/{}.vim", "after/plugin/{}.vim"]
  \   },
  \   "autoload/*.vim": {
  \     "type": "autoload",
  \     "alternate": ["plugin/{}.vim", "after/plugin/{}.vim"]
  \   },
  \   "after/plugin/*.vim": {
  \     "type": "after",
  \     "alternate": ["plugin/{}.vim", "autoload/{}.vim"]
  \   },
  \   "ftplugin/*.vim": {
  \     "type": "ftplug"
  \   }
  \ },
  \ "venv/|requirements.txt": {
  \   "*.py": {
  \     "type": "code",
  \     "alternate": ["tests/test_{basename}"]
  \   },
  \   "tests/test_*.py": {
  \     "type": "test",
  \     "alternate": ["{project|basename}/{}.py"]
  \   }
  \ }
  \}
