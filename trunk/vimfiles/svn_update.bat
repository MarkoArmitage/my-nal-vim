@echo off

svn update

REM xcopy  /e /y  /f  .vimperator  ..\vimperator
copy .vimrc ..\_vimrc
copy .vimperatorrc ..\_vimperatorrc



REM 参数
REM Source
REM 必需的。指定要复制的文件的位置和名称。该参数必须包含驱动器或路径。
REM Destination
REM 指定要复制的文件的目标。该参数可以包含驱动器盘符和冒号、目录名、文件名或者它们的组合。
REM /w
REM 在开始复制文件之前将显示以下消息并等待您的响应：
REM Press any key to begin copying file(s)

REM /p
REM 提示您确认是否要创建每个目标文件。
REM /c
REM 忽略错误。
REM /v
REM 在写入目标文件时验证每个文件，以确保目标文件与源文件完全相同。
REM /q
REM 禁止显示 xcopy 消息。
REM /f
REM 复制时显示源文件名和目标文件名。
REM /l
REM 显示要复制的文件列表。
REM /g
REM 创建解密的目标文件。
REM /d[:mm-dd-yyyy]
REM 只复制那些在指定日期或指定日期之后更改过的源文件。如果不包括 mm-dd-yyyy 值，xcopy 会复制比现有 Destination 文件新的所有 Source 文件。该命令行选项使您可以更新更改过的文件。
REM /u
REM 只从 source 复制 destination 中已有的文件。
REM /i
REM 如果 Source 是一个目录或包含通配符，而 Destination 不存在，xcopy 会假定 destination 指定目录名并创建一个新目录。然后，xcopy 会将所有指定文件复制到新目录中。默认情况下，xcopy 将提示您指定 destination 是文件还是目录。
REM /s
REM 复制非空的目录和子目录。如果省略 /s，xcopy 将在一个目录中工作。
REM /e
REM 复制所有子目录，包括空目录。同时使用 /e、/s 和 /t 命令行选项。
REM /t
REM 只复制子目录结构（即目录树），不复制文件。要复制空目录，必须包含 /e 命令行选项。
REM /k
REM 复制文件，如果源文件具有只读属性，则在目标文件中保留该属性。默认情况下，xcopy 会删除只读属性。
REM /r
REM 复制只读文件。
REM /h
REM 复制具有隐藏和系统文件属性的文件。默认情况下，xcopy 不复制隐藏或系统文件。
REM /a
REM 只复制那些具有存档文件属性设置的源文件。/a 不修改源文件的存档文件属性。有关如何通过使用 attrib 来设置存档文件属性的信息，请参阅“”。
REM /m
REM 复制具有存档文件属性设置的源文件。与 /a 不同，/m 关闭在源中指定的文件的存档文件属性。有关如何通过使用 attrib 来设置存档文件属性的信息，请参阅“”。
REM /n
REM 使用 NTFS 短文件或目录名创建副本。将文件或目录从 NTFS 卷复制到 FAT 卷或者当目标文件系统需要 FAT 文件系统命名约定（即 8.3 个字符）时，需要 /n。目标文件系统可以是 FAT 或 NTFS。
REM /o
REM 复制文件所有权与自由选择的访问控制列表 (DACL) 信息。
REM /x
REM 复制文件审核设置和系统访问控制列表 (SACL) 信息（包含 /o）。
REM /exclude:filename1[+[filename2]][+[filename3]]
REM 指定包含字符串的文件列表。
REM /y
REM 禁止提示您确认要覆盖现存的目标文件。
REM /-y
REM 提示您确认要覆盖现有目标文件。
REM /z
REM 在可重启模式中通过网络复制。
REM REM /? 

