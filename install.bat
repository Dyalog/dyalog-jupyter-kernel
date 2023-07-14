@echo off
set CMD=python -c "import site; sp=site.getsitepackages(); print(sp[1])"
for /F "tokens=* USEBACKQ" %%F in (`%CMD%`) do (set SITE_PACKAGES=%%F)
echo %SITE_PACKAGES%
xcopy %0\..\dyalog-kernel %APPDATA%\jupyter\kernels\dyalog-kernel /Y /I
xcopy %0\..\dyalog_kernel %SITE_PACKAGES%\dyalog_kernel /Y /I

