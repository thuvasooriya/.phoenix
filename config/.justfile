set shell := ["nu", "-c"]

router_ip := `netstat -nr | awk '$1=="default" && $NF=="en0" {print $2; exit}'`

@default:
    # just --choose
    just --list --list-heading ''

# command to sync required directories to respective drives
@gdsync:
    rclone bisync gdrive:arc/lib /Users/tony/arc/lib --create-empty-src-dirs --compare size,modtime,checksum --slow-hash-sync-only --resilient -MvP --drive-skip-gdocs --fix-case --resync --exclude ".DS_Store"
    rclone bisync gdrive:arc/now/sm4 /Users/tony/arc/now/sm4 --create-empty-src-dirs --compare size,modtime,checksum --slow-hash-sync-only --resilient -MvP --drive-skip-gdocs --fix-case --resync --exclude {.DS_Store, **/.stfolder/**}
    rclone bisync gdrive:arc/vlt /Users/tony/arc/vlt --create-empty-src-dirs --compare size,modtime,checksum --slow-hash-sync-only --resilient -MvP --drive-skip-gdocs --fix-case --resync --exclude ".DS_Store"

# aria2 python script for adding download links
@aria:
    python3 ~/.config/aria2/aria2.py

# mirror android device
scrcpy mode='d':
    adb kill-server
    if {{ mode }} == "e" { adb tcpip 5555 } else { }
    if {{ mode }} == "e" { adb connect {{ router_ip }}:5555 } else { }
    adb devices

mirror mode='d':
    scrcpy --video-codec=h265 --max-fps=30 --no-audio --no-mouse-hover --render-driver metal -{{ mode }}

@test:
    echo {{ router_ip }}

androdio:
    scrcpy --no-window --audio-buffer=200

binup:
    bun upgrade
    pixi self-update
    zvm upgrade
    zvm i --zls master
    rustup update
