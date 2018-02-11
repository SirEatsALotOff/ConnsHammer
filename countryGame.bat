@echo off
@setlocal enabledelayedexpansion
@set /p cityCount= How many countries exist up to 5?
if "%cityCount%"=="" (set cityCount=5)
set starterCounter=0
set landLoopVar=0
:generateLand
set line1=%random%%random%
set line2=%random%%random%
set line3=%random%%random%
set "land=!line1:~0,2!"
set "fertile=!line2:~0,2!"
set "lush=!line3:~0,2!"
set /a availableland=%land%+%fertile%+%lush%
set /a math1a=%land%*100
set /a math1b=%math1a%/%availableland%
set /a math2a=%fertile%*100
set /a math2b=%math2a%/%availableland%
set /a math3a=%lush%*100
set /a math3b=%math3a%/%availableland%
set /a testFull=%math1b%+%math2b%+%math3b%
if %testFull% LEQ 99 (
set /a math1b=%math1b%+1
)
set /a testFull=%math1b%+%math2b%+%math3b%
if %testFull% LEQ 99 (
set /a math1b=%math1b%+1
)
set /a testFull=%math1b%+%math2b%+%math3b%
if %testFull% LEQ 99 (
set /a math1b=%math1b%+1
)
@echo %math1b% Percent Plains
@echo %math2b% Percent Fertile
@echo %math3b% Percent Lush
if %math1b% LEQ 9 (
@echo Error, programmer was too lazy to program a better way to weight the percentages.
@echo Also you were unlucky enough to get less than 10 plains... oh well.
goto generateLand
)
@echo Land data generated, writing to a map...
@echo Setting biome centers...

::fertile and lush both work for the 2 digit numbers. Land will just fill in.
set "ABCvar1=!lush:~0,1!"
set numI=lushCenterABC
set abcRead=1
	call :letterConvert
set "ABCvar2=!fertile:~0,1!"
set abcRead=2
set numI=fertileCenterABC
	call :letterConvert
set "NUMvar1=!lush:~1,1!"
set "NUMvar2=!fertile:~1,1!"
set lushCenter=%lushCenterABC%%NUMvar1%
::generates the a1 like coordinate. Please note the entire column J is
::unused and will be filled in with plain land.
::Might fix in the future, but it sounds like a giant pain in the ass right now.
set fertileCenter=%fertileCenterABC%%NUMvar2%

:setLandLoop
set /a landLoopVar=%landLoopVar%+1
::1 is land, 2 is fertile, 3 is lush. I'm not focusing on rendering right now, this is purely simulative.
set "a%landLoopVar%=1"
set "b%landLoopVar%=1"
set "c%landLoopVar%=1"
set "d%landLoopVar%=1"
set "e%landLoopVar%=1"
set "f%landLoopVar%=1"
set "g%landLoopVar%=1"
set "h%landLoopVar%=1"
set "i%landLoopVar%=1"
set "j%landLoopVar%=1"

if %landLoopVar%==10 goto setHives
if %landLoop%Var==10 goto numericalI
goto setLandLoop
:setHives
set %lushCenter%=3
set %fertileCenter%=2
@echo Now comes the fun part of generating the land in a reasonable way...
::and here we find our immediate neighbors in a 3x3 grid and see if they're on the map.
:: tL tM tR
:: mL 00 mR
:: bL bM bR
:: NUMvar1 is the lush number
:: NUMvar2 is the fertile number
:adjacentFinder
if %NUMvar1%==0 set NUMvar1=1
if %ABCvar%==0 set ABCvar=1
if %NUMvar1% GEQ 2 (
	if %ABCvar1% GEQ 2 (
		set /a varT2=%NUMvar1%-1
		set /a varT1=%ABCvar1%+1
		set numI=varT1
		call :numConverter
	set tL=%varT1%%varT2%
	)
	if %ABCvar1% LEQ 9 (
		set /a varT2=%NUMvar1%-1
		set /a varT1=%ABCvar1%-1
		set numI=varT1
		call :numConverter
		set bL=%varT1%%varT2%
	)
	set /a varT2=%NUMvar1%-1
	set varT1=%ABCvar1%
	set numI=varT1
	call :numConverter
	
	set mL=%ABCvar1%%varT1%
)
if %ABCvar1% GEQ 2 (
	set varT2=%NUMvar1%
	set /a varT1=%ABCvar1%-1
	set numI=varT1
	call :numConverter
	set tM=%varT1%%varT2%
)
if %ABCvar1% LEQ 9 (
	set varT2=%NUMvar1%
	set /a varT1=%ABCvar1%-1
	set numI=varT1
	call :numConverter
	set bM=%varT1%%varT2%
)
if %NUMvar1% LEQ 9 (
	if %ABCvar1% GEQ 2 (
		set /a varT2=%NUMvar1%-1
		set /a varT1=%ABCvar1%+1
		set numI=varT1
		call :numConverter
	set tR=%varT1%%varT2%
	)
	if %ABCvar1% LEQ 9 (
		set /a varT2=%NUMvar1%-1
		set /a varT1=%ABCvar1%-1
		set numI=varT1
		call :numConverter
		set bR=%varT1%%varT2%
	)
	set /a varT2=%NUMvar1%-1
	set varT1=%ABCvar1%
	set numI=varT1
	call :numConverter
	set mR=%ABCvar1%%varT1%
)
::Well that was nice to finish, takes up half the lines and took me 3 hours. Well onto the next one that's almost the exact same!
if %NUMvar2% GEQ 2 (
	if %ABCvar2% GEQ 2 (
		set /a varT2=%NUMvar2%-1
		set /a varT1=%ABCvar2%+1
		set numI=varT1
		call :numConverter
	set FtL=%varT1%%varT2%
	)
	if %ABCvar2% LEQ 9 (
		set /a varT2=%NUMvar2%-1
		set /a varT1=%ABCvar2%-1
		set numI=varT1
		call :numConverter
		set FbL=%varT1%%varT2%
	)
	set /a varT2=%NUMvar2%-1
	set varT1=%ABCvar2%
	set numI=varT1
	call :numConverter
	
	set /a FmL=%ABCvar2%%varT1%
)
if %ABCvar2% GEQ 2 (
	set varT2=%NUMvar2%
	set /a varT1=%ABCvar2%-1
	set numI=varT1
	call :numConverter
	set FtM=%varT1%%varT2%
)
if %ABCvar2% LEQ 9 (
	set varT2=%NUMvar2%
	set /a varT1=%ABCvar2%-1
	set numI=varT1
	call :numConverter
	set FbM=%varT1%%varT2%
)

if %NUMvar2% LEQ 9 (
	if %ABCvar2% GEQ 2 (
		set /a varT2=%NUMvar2%-1
		set /a varT1=%ABCvar2%+1
		set numI=varT1
		call :numConverter
	set FtR=%varT1%%varT2%
	)
	if %ABCvar2% LEQ 9 (
		set /a varT2=%NUMvar2%-1
		set /a varT1=%ABCvar2%-1
		set numI=varT1
		call :numConverter
		set FbR=%varT1%%varT2%
	)
	set /a varT2=%NUMvar2%-1
	set varT1=%ABCvar2%
	set numI=varT1
	call :numConverter
	set FmR=%ABCvar2%%varT1%
)

:citySetLoop
set /a starterCounter=%starterCounter%+1
set loopcount=%starterCounter%
if %starterCounter%==%cityCount% goto doneStart
set country%starterCounter%Population=10
set country%starterCounter%Food=10
set country%starterCounter%Gold=10
set country%starterCounter%Tech=0
goto citySetLoop
:doneStart
@echo Done with initial variables...
pause
exit
:letterConvert
set ABCvar=%ABCvar%!abcRead!
if %ABCvar%==1 (set %numI%=a)
if %ABCvar%==2 (set %numI%=b)
if %ABCvar%==3 (set %numI%=c)
if %ABCvar%==4 (set %numI%=d)
if %ABCvar%==5 (set %numI%=e)
if %ABCvar%==6 (set %numI%=f)
if %ABCvar%==7 (set %numI%=g)
if %ABCvar%==8 (set %numI%=h)
if %ABCvar%==9 (set %numI%=i)

goto :eof


:numConverter
if %varT2%==1 (set %numI%=a)
if %varT2%==2 (set %numI%=b)
if %varT2%==3 (set %numI%=c)
if %varT2%==4 (set %numI%=d)
if %varT2%==5 (set %numI%=e)
if %varT2%==6 (set %numI%=f)
if %varT2%==7 (set %numI%=g)
if %varT2%==8 (set %numI%=h)
if %varT2%==9 (set %numI%=i)

goto :eof
:numericalI
@echo Land generated
goto citySetLoop