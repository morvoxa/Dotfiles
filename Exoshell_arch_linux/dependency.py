import os
import subprocess
import shutil
import time

def run_command(command, use_sudo=False):
    if use_sudo:
        command = f"sudo {command}"
    try:
        subprocess.run(command, shell=True, check=True)
        return True
    except subprocess.CalledProcessError:
        return False

def install_with_makepkg(package_name):
    print(f"\n--- Menginstall {package_name} via makepkg ---")
    build_dir = os.path.expanduser(f"~/tmp_build_{package_name}")
    aur_url = f"https://aur.archlinux.org/{package_name}.git"
    
    max_retries = 100
    success = False

    for i in range(max_retries):
        # Bersihkan direktori build lama jika ada sisa error sebelumnya
        if os.path.exists(build_dir):
            shutil.rmtree(build_dir)
        
        print(f"Mencoba clone {package_name} (Percobaan {i+1}/{max_retries})...")
        
        if run_command(f"git clone {aur_url} {build_dir}"):
            success = True
            break
        else:
            print(f"Gagal melakukan clone {package_name}. Mengulang dalam 3 detik...")
            time.sleep(3)

    if success:
        try:
            os.chdir(build_dir)
            # -s: install dependencies, -i: install package
            run_command("makepkg -si --noconfirm")
        finally:
            os.chdir(os.path.expanduser("~"))
            shutil.rmtree(build_dir)
    else:
        print(f"CRITICAL ERROR: Gagal mendownload {package_name} setelah {max_retries} percobaan.")

def main():
    # Pastikan dependensi dasar
    run_command("pacman -S --needed --noconfirm base-devel git", use_sudo=True)

    dependencies = [
        "material-symbols-git",
        "python-ignis-git",
        "ignis-gvc",
        "matugen-bin",
        "swww",
        "gnome-bluetooth-3.0",
        "adw-gtk-theme",
        "dart-sass",
    ]

    for pkg in dependencies:
        # Cek apakah paket ada di repo resmi
        check_pkg = subprocess.run(f"pacman -Si {pkg}", shell=True, capture_output=True)
        
        if check_pkg.returncode == 0:
            run_command(f"pacman -S --needed --noconfirm {pkg}", use_sudo=True)
        else:
            install_with_makepkg(pkg)

if __name__ == "__main__":
    main()
