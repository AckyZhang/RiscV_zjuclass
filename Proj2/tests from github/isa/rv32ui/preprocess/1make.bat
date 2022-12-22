md made
for %%i in (*.S) do (mingw32-make > %%~ni.txt)
for %%f in (*.o) do del %%f
for %%k in (*.om) do del %%k
for %%s in (*.S) do move %%s ./made