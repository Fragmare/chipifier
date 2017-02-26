SET /P CHIPRATE=Enter new sample rate in Hz: 
IF [%CHIPRATE%]==[] GOTO :END

@ECHO Cleanup from before
del %1.*.dmw
del %1.CHIPIFIED.wav
del %1.CHIPIFIED.wav.txt

@ECHO Convert to mono, resample and normalize to peak...
sox -D %1 -c 1 -r "%CHIPRATE%" "%~1.TMP1.wav"
sox -D "%~1.TMP1.wav" "%~1.TMP2.wav" norm
@ECHO Readjust volume for 5-bit...
sox -D -v 0.00048829615 "%~1.TMP2.wav" "%~1.CHIPIFIED.wav"

@ECHO Outputs myfile.wav.CHIPIFIED.wav.0.dmw, etc. wavetable files
chipifier "%~1.CHIPIFIED.wav"

del %1.TMP*.wav

:END
