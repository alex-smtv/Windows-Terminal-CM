@echo off
rem *************************************************************************************
rem This bat file defines useful variables used for installation and uninstallation.
rem
rem Usage  : _SharedVars.bat [option]
rem Options (choose one):
rem     setup :: Setup the variables
rem     clean :: Clean the variables
rem *************************************************************************************

IF "%1"=="setup" (
    goto SETUP
) ELSE (
    IF "%1"=="clean" (
        goto CLEAN
    ) ELSE (
        echo.
        echo Error. Please use the 'setup' or 'clean' option with the shared variables script ^(used: %1^).
        echo.
        pause
        exit /b 1
    )
)

:SETUP
SET "_SEPARATOR=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^=^="

SET "_SCRIPT_ICON_FOLDER=icon"

SET "_MENU_ICON_NAME=terminal.ico"
SET "_MENU_ICON_FPATH=%LOCALAPPDATA%\Windows_Terminal_CM"

SET "_WINDOWS_TERMINAL_PATH=%LOCALAPPDATA%\Microsoft\WindowsApps\wt.exe"
SET "_WINDOWS_TERMINAL_ARGUMENTS=\"-w\" \"0\" \"nt\" \"-d\" \"%%V\""

SET "_REG_KEY=Windows Terminal CM"
SET "_REG_MENU_NAME=Open Windows Terminal here"
SET "_REG_MENU_ICON_PATH=%_MENU_ICON_FPATH%\%_MENU_ICON_NAME%"
SET "_REG_WINDOWS_TERMINAL_CMD=\"%_WINDOWS_TERMINAL_PATH%\" %_WINDOWS_TERMINAL_ARGUMENTS%"

goto END

:CLEAN
SET "_SCRIPT_ICON_FOLDER="

SET "_MENU_ICON_NAME="
SET "_MENU_ICON_FPATH="

SET "_WINDOWS_TERMINAL_PATH="
SET "_WINDOWS_TERMINAL_ARGUMENTS="

SET "_REG_KEY="
SET "_REG_MENU_NAME="
SET "_REG_MENU_ICON_PATH="
SET "_REG_WINDOWS_TERMINAL_CMD="

goto END

:END
exit /b %ERRORLEVEL%