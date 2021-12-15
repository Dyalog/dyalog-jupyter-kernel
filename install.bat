@echo off
xcopy %0\..\dyalog-kernel %APPDATA%\jupyter\kernels\dyalog-kernel /Y /I
xcopy %0\..\dyalog_kernel %APPDATA%\Python\Python36\site-packages\dyalog_kernel /Y /I
xcopy %0\..\dyalog_kernel %USERPROFILE%\AppData\Local\Continuum\anaconda3\Lib\site-packages\dyalog_kernel /Y /I
xcopy %0\..\dyalog_kernel %USERPROFILE%\anaconda3\Lib\site-packages\dyalog_kernel /Y /I
xcopy %0\..\dyalog_kernel %USERPROFILE%\Miniconda3\Lib\site-packages\dyalog_kernel /Y /I
