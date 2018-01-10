rem Building on windows requires the following pieces of software:
rem rust 1.22.0
rem visual studio 2017 CE
rem jdk 8
rem python 3.6 64-bit
rem    pip setuptools cffi nose

cd bindings
python generate.py
if %errorlevel% neq 0 exit /b %errorlevel%

cargo build
@if %errorlevel% neq 0 exit /b %errorlevel%

cd python
python setup.py build_ext --inplace
@if %errorlevel% neq 0 exit /b %errorlevel%

cd ../java/src/bc
swig -java -package bc -outcurrentdir ../../../c/include/bc.i)
@if %errorlevel% neq 0 exit /b %errorlevel%

cd ../..
javac src/bc/*.java
@if %errorlevel% neq 0 exit /b %errorlevel%

nmake /f windows.mk