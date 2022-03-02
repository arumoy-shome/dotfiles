Captured items go here.

# [2022-02-22 Tue 13:58] improve `TODO` highlight :vim:feature:
The current highlight for `TODO` keywords is terrible. A subtle yellow
is required.

# [2022-02-22 Tue 10:00] implement capture :aims:feature:
This is my second attempt writing an information management system
using unix commands. This time around, I am going to take a more agile
approach to the development cycle.

Implement the capture sub-command. This also includes the Vim wrapper.
All captured items should be **appended** into `inbox.md`.

This is different from the original implementation which created new
files for each captured item. The original implementation, while made
sense on paper, didn't work too well when reviewing all captured
items, as it required relying on the `find` command heavily. Having
all captured items in a single file makes it easy to review them
quickly. It also leaves the responsibility of extracting a note into a
separate file to the human. I think this works well because 90% of
captured items is noise.

The template should include a. a level 1 markdown header and
b. a datetime-stamp. The remainder of the info is to be filled by the
user allowing for maximum flexibility to add as much metadata as the
user sees relevant.

