@echo off
rem *************************************************************************************
rem This bat file manages the installation and uninstallation of  the context menu 
rem for the Windows Terminal.
rem
rem Usage  : Manager.bat [option]
rem Options (choose one):
rem     install   :: Install the Windows Terminal context menu
rem     uninstall :: Uninstall the Windows Terminal context menu
rem *************************************************************************************

echo ^>^>^> The script is now running...

call "%~dp0"_SharedVars.bat setup

IF %ERRORLEVEL% neq 0 (goto INI_FAILED) ELSE (goto CHECK_OPTION)

:INI_FAILED
@echo off
echo.
echo =============================================================
echo ==^> Error
echo =============================================================
echo.
echo ^>^>^> Variables initialization failed. The script is not allowed to continue and will now end.
echo.
pause
goto CLEAN_EXIT_ERROR

:CHECK_OPTION
@echo off
IF "%1"=="install" (
    goto INSTALL
) ELSE (
    IF "%1"=="uninstall" (
        goto UNINSTALL
    ) ELSE (
        echo.
        echo Error. Please use the 'install' or 'uninstall' option with the manager script ^(used: %1^).
        echo.
        pause
        goto CLEAN_EXIT_ERROR
    )
)

:INSTALL
@echo off
echo.
echo =============================================================
echo ==^> Copy icon to a custom folder in local AppData folder
echo =============================================================

@echo on
robocopy "%~dp0..\%_SCRIPT_ICON_FOLDER%" "%_MENU_ICON_FPATH%" "%_MENU_ICON_NAME%" /E /IS /IT

@echo off
IF %ERRORLEVEL% geq 8 (goto COPY_FAILED) ELSE (goto COPY_SUCCESS)

:COPY_SUCCESS
@echo off
echo =============================================================
echo ==^> Add keys and values to the registry
echo =============================================================

@echo on
reg add "HKCU\Software\Classes\Directory\shell\%_REG_KEY%" /d "%_REG_MENU_NAME%" /f
reg add "HKCU\Software\Classes\Directory\shell\%_REG_KEY%" /v icon /d "%_REG_MENU_ICON_PATH%" /f
reg add "HKCU\Software\Classes\Directory\shell\%_REG_KEY%\command" /t REG_EXPAND_SZ /d "%_REG_WINDOWS_TERMINAL_CMD%" /f

reg add "HKCU\Software\Classes\Directory\Background\shell\%_REG_KEY%" /d "%_REG_MENU_NAME%" /f
reg add "HKCU\Software\Classes\Directory\Background\shell\%_REG_KEY%" /v icon /d "%_REG_MENU_ICON_PATH%" /f
reg add "HKCU\Software\Classes\Directory\Background\shell\%_REG_KEY%\command" /t REG_EXPAND_SZ /d "%_REG_WINDOWS_TERMINAL_CMD%" /f

reg add "HKCU\Software\Classes\LibraryFolder\Background\shell\%_REG_KEY%" /d "%_REG_MENU_NAME%" /f
reg add "HKCU\Software\Classes\LibraryFolder\Background\shell\%_REG_KEY%" /v icon /d "%_REG_MENU_ICON_PATH%" /f
reg add "HKCU\Software\Classes\LibraryFolder\Background\shell\%_REG_KEY%\command" /t REG_EXPAND_SZ /d "%_REG_WINDOWS_TERMINAL_CMD%" /f

@echo off
echo.
echo =============================================================
echo ==^> End
echo =============================================================
echo.
echo ^>^>^> End of the script. A context menu for Windows Terminal has been added.
echo ^>^>^> Right click inside your explorer and look for "%_REG_MENU_NAME%".
echo.
pause
goto CLEAN_EXIT

:COPY_FAILED
@echo off
echo.
echo =============================================================
echo ==^> Error
echo =============================================================
echo.
echo ^>^>^> An error occurred while trying to copy the context menu icon. The error code is %ERRORLEVEL%.
echo ^>^>^> The script has stopped and will now end.
echo.
pause
goto CLEAN_EXIT_ERROR

:UNINSTALL
@echo off
echo.
echo =============================================================
echo ==^> Remove folder created in local AppData folder
echo =============================================================

@echo on
rmdir %_MENU_ICON_FPATH% /S /Q

@echo off
echo.
echo =============================================================
echo ==^> Remove keys and values of the registry
echo =============================================================

@echo on
reg delete "HKCU\Software\Classes\Directory\shell\%_REG_KEY%" /f
reg delete "HKCU\Software\Classes\Directory\Background\shell\%_REG_KEY%" /f
reg delete "HKCU\Software\Classes\LibraryFolder\Background\shell\%_REG_KEY%" /f

@echo off
echo.
echo =============================================================
echo ==^> End
echo =============================================================
echo.
echo ^>^>^> End of the script. The context menu for Windows Terminal has been removed.
echo.
pause
goto CLEAN_EXIT

:CLEAN_EXIT
call "%~dp0"_SharedVars.bat clean
exit /b %ERRORLEVEL%

:CLEAN_EXIT_ERROR
call "%~dp0"_SharedVars.bat clean
exit /b 1