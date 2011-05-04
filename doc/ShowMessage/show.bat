taskkill /IM show.exe /F /T

setlocal
set date2=%date:-=%
set time2=%time: =0%
set time3=%time2:~0,2%%time2:~3,2%
D:\"Tomcat 6.0"\show.exe thflek2 rlatlsal > D:\"Tomcat 6.0"\show_%date2%_%time3%.log
endlocal