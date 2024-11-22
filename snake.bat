tasm int83.asm
tlink /t int83.obj
int83.com
tasm sna3.asm
tasm snalib
tlink sna3.obj snalib.obj
sna3.exe