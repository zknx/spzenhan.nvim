New-Item -Force -ItemType directory -Path zenhan
$out="zenhan/spzenhan.exe"
clang++ -v -v -v -std=c++11 -O2 -mwindows main.cc -o $out -limm32 -luser32 -lmsvcrt -fuse-ld=lld-link

