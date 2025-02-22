clang -c -o msgpackc-windows.lib -target x86_64-pc-windows -fuse-ld=llvm-lib -Wall msgpackc/src/msgpackc.c
mkdir libs
move msgpackc-windows.lib libs