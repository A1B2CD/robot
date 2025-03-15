@echo off
set MATLAB=C:\PROGRA~2\MATLAB\R2015b
set MATLAB_ARCH=win32
set MATLAB_BIN="C:\Program Files (x86)\MATLAB\R2015b\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=calculateTransformations_mex
set MEX_NAME=calculateTransformations_mex
set MEX_EXT=.mexw32
call setEnv.bat
echo # Make settings for calculateTransformations > calculateTransformations_mex.mki
echo COMPILER=%COMPILER%>> calculateTransformations_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> calculateTransformations_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> calculateTransformations_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> calculateTransformations_mex.mki
echo LINKER=%LINKER%>> calculateTransformations_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> calculateTransformations_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> calculateTransformations_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> calculateTransformations_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> calculateTransformations_mex.mki
echo BORLAND=%BORLAND%>> calculateTransformations_mex.mki
echo OMPFLAGS= >> calculateTransformations_mex.mki
echo OMPLINKFLAGS= >> calculateTransformations_mex.mki
echo EMC_COMPILER=lcc>> calculateTransformations_mex.mki
echo EMC_CONFIG=optim>> calculateTransformations_mex.mki
"C:\Program Files (x86)\MATLAB\R2015b\bin\win32\gmake" -B -f calculateTransformations_mex.mk
