# ---- Safe aliases (no conflicts) ----
Set-Alias asm nasm
Set-Alias vi notepad
Set-Alias grep findstr

# ---- Optimized C runner ----
function runc {
    param ([string]$file)

    $out = [IO.Path]::GetFileNameWithoutExtension($file)

    gcc -O3 -march=native $file -o $out
    if ($?) {
        & ".\$out.exe"
    }
}

function rembin {
    Remove-Item -Force *.exe, *.o, *.obj, *.ppm, *.tmp -ErrorAction SilentlyContinue
}

function cdir {
    Remove-Item -Force *.c, *.asm, *.py, *.java, *.cpp, *.h, *.class -ErrorAction SilentlyContinue
}

function clean {
    rembin
    cdir
}


function lgdic {
    param ([string]$file)

    $out = [IO.Path]::GetFileNameWithoutExtension($file)

    gcc -O3 $file -lgdi32 -o $out
    if ($?) {
        & ".\$out.exe"
    }
}

# ---- NASM runner ----
function asmb {
    param ([string]$file)

    $out = [IO.Path]::GetFileNameWithoutExtension($file)
    nasm -f win64 $file -o "$out.obj"
}

# ---- ASM to C linker ----
function linkc {
    param ([string]$obj)

    $exe = [IO.Path]::GetFileNameWithoutExtension($obj)
    gcc $obj -o $exe
}

# ---- Run ASM Files ----
function runasm {
    param ([string]$file)

    $base = [IO.Path]::GetFileNameWithoutExtension($file)
    $obj  = "$base.obj"
    $exe  = "$base.exe"

    asmb $file
    if (!$?) { return }

    linkc $obj
    if (!$?) { return }

    & ".\$exe"
}

# ---- Open profile fast ----
function op {
    notepad $PROFILE
}

# ---- Startup banner ----
function banner {
    $user = $env:USERNAME
    Write-Host "=================================" -ForegroundColor Green
    Write-Host "              $user              " -ForegroundColor Cyan
    Write-Host "=================================" -ForegroundColor Green
}

function prof{

    # --- OS info ---
    $os = (Get-CimInstance Win32_OperatingSystem)
    $osName = $os.Caption
    $osVer  = $os.Version

    # --- Core system ---
    $arch = $env:PROCESSOR_ARCHITECTURE
    $user = $env:USERNAME

    # --- Kernel (Windows main DLL) ---
    $kernel = "kernel32.dll"

    # --- CPU info ---
    $cpu = Get-CimInstance Win32_Processor
    $cpuName = $cpu.Name.Trim()

    Write-Host ""
    Write-Host "System Profile" -ForegroundColor Cyan
    Write-Host "---------------------------------" -ForegroundColor DarkGray

    Write-Host "User        : $user" -ForegroundColor Green
    Write-Host "OS          : $osName ($osVer)" -ForegroundColor Yellow
    Write-Host "Arch        : $arch" -ForegroundColor Magenta
    Write-Host "CPU         : $cpuName" -ForegroundColor Cyan
    Write-Host "Kernel      : $kernel" -ForegroundColor DarkGreen

    Write-Host "---------------------------------" -ForegroundColor DarkGray
    Write-Host ""
}

function pop {
    param (
        [Parameter(Mandatory = $true)]
        [string]$script
    )

    $bak = "$PROFILE.bak"

    if (-not (Test-Path $script)) {
        Write-Host "[ERR] File not found: $script" -ForegroundColor Red
        return
    }

    $content = Get-Content $script -Raw

    #  profile safety check
    if ($content -match '^\s*param\s*\(') {
        Write-Host "[ERR] Script contains top-level param(). Not a valid profile." -ForegroundColor Red
        return
    }

    Copy-Item $PROFILE $bak -Force
    Write-Host "[INFO] Backup saved to $bak" -ForegroundColor DarkGray

    Set-Content -Path $PROFILE -Value $content -Encoding UTF8
    Write-Host "[OK] Profile overwritten with $script" -ForegroundColor Green

    notepad $PROFILE
}

# ---- Show banner on startup ----
banner
