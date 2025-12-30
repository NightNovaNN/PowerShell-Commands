# PowerShell-Commands
A small set of PS1 commands to boost productivity and boost LAZINESS.

## Usage

```sh
# Cloning
git clone https://github.com/NightNovaNN/PowerShell-Commands
cd PowerShell-Commands

# Using
. .\Profile.ps1
```

## Functions

- `runc <FILE>`: Links and Runs File.  
- `rembin`: Deletes all binaries in the current dir.  
- `cdir`: Deletes the Files in the dir.  
- `clean`: Does _rembin_ + _cdir_.  
- `lgdic <FILE>`: Links a _C_ files with **-lgdic** flag.  
- `asmb <FILE>`: Links an ASM file using NASM into _.obj_.  
- `linkc <FILE>`: Links the generated _.obj_ and links using **GCC**.  
- `runasm <FILE>`: Does _asmb_ + _linkc_ and runs the generated Executable.  
- `op`: Opens the _PS1 PROFILE_ running **notepad $PROFILE**.  
- `banner`: Makes a banner with your Desktop Username and displays it.  
- `prof`: Gives information about your PC.  
- `pop <FILE>`: Opens Profile and replaces it with the _.ps1_ file in args, also backs it up.  

## Aliases

- `asm` for _nasm_.  
- `vi` for _notepad_.  
- `grep` for _findstr_.

---
