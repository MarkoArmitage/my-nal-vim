# .pyclewn_keys.gdb file
#
# The default placement for this file is $CLEWNDIR/.pyclewn_keys.gdb, or
# $HOME/.pyclewn_keys.gdb
#
# Key definitions are of the form `KEY:COMMAND'
# where the following macros are expanded:
#    ${text}:   the word or selection below the mouse
#    ${fname}:  the current buffer full pathname
#    ${lnum}:   the line number at the cursor position
#
# All characters following `#' up to the next new line are ignored.
# Leading blanks on each line are ignored. Empty lines are ignored.
#
# To tune the settings in this file, you will have to uncomment them,
# as well as change them, as the values on the commented-out lines
# are the default values. You can also add new entries. To remove a
# default mapping, use an empty GDB command.
#
# Supported key names:
#       . key functions: F1 to F20, example: `F11:continue'
#       . uppercase characters, example: 'S-Q:quit'
#       . control characters, example: 'C-U:up'
#
#
# C-B : break "${fname}":${lnum} # set breakpoint at current line
# C-D : down
# C-E : clear "${fname}":${lnum} # clear breakpoint at current line
# C-N : next
# C-P : print ${text}            # print value of selection at mouse position
# C-U : up
# C-X : print *${text}           # print value referenced by word at mouse position
# C-Z : sigint                   # kill the inferior running program
# S-A : info args
# S-B : info breakpoints
# S-C : continue
# S-F : finish
# S-L : info locals
# S-Q : quit
# S-R : run
# S-S : step
# S-W : where
# S-X : foldvar ${lnum}          # expand/collapse a watched variable
