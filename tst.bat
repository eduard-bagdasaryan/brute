@echo off  
  
rem 5c8df559fbbe5156c06996be9c34397f hash for "lzx"
rem Evaluating execution time for one thread
brute.exe 2 3 65-90:97-122 5c8df559fbbe5156c06996be9c34397f 1
rem Evaluating execution time for two threads
brute.exe 2 3 65-90:97-122 5c8df559fbbe5156c06996be9c34397f 4 
