@echo off

copy ..\_vimrc .vimrc 
copy ..\_vimperatorrc .vimperatorrc 

svn commit %1 %2

REM echo %1
REM echo %2
REM echo %3
REM echo %*

