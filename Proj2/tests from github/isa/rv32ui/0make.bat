md preprocess
for %%i in (*.S) do gcc -E %%i -o ./preprocess/%%i
