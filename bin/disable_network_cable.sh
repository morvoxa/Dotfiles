#!/bin/bash
# =======================================
# Script: toggle-wired-nic.sh
# Tujuan: Enable / Disable NIC kabel sampai level kernel
# =======================================

# Pastikan dijalankan sebagai root
if [[ $EUID -ne 0 ]]; then
   echo "Harap jalankan script ini sebagai root"
   exit 1
fi

# Fungsi untuk mendeteksi NIC kabel
get_nics() {
    # Interface yang biasanya ethernet: eth*, enp*, eno*
    ls /sys/class/net | grep -E '^e|^en|^eth'
}

# Fungsi disable NIC
disable_nic() {
    NIC_LIST=$(get_nics)
    if [ -z "$NIC_LIST" ]; then
        echo "Tidak ada NIC kabel terdeteksi."
        return
    fi

    for NIC in $NIC_LIST; do
        echo "Mematikan interface $NIC..."
        ip link set "$NIC" down

        DRIVER=$(basename $(readlink /sys/class/net/$NIC/device/driver 2>/dev/null))
        if [ -n "$DRIVER" ]; then
            echo "Unloading driver $DRIVER untuk $NIC..."
            modprobe -r "$DRIVER" 2>/dev/null || echo "Gagal unload $DRIVER (mungkin digunakan kernel)"
        fi
    done
    echo "Semua NIC kabel dimatikan dan driver dilepas."
}

# Fungsi enable NIC
enable_nic() {
    NIC_LIST=$(get_nics)
    if [ -z "$NIC_LIST" ]; then
        echo "Tidak ada NIC kabel terdeteksi. Memuat driver..."
        # Coba detect driver yang sebelumnya di-unload
        # Catatan: harus diubah sesuai driver sistem
        DRIVER_LIST=("e1000e" "r8169" "tg3") # Tambahkan driver NIC yang umum
        for DRIVER in "${DRIVER_LIST[@]}"; do
            echo "Memuat driver $DRIVER..."
            modprobe "$DRIVER" 2>/dev/null && echo "Driver $DRIVER dimuat"
        done
        NIC_LIST=$(get_nics)
        if [ -z "$NIC_LIST" ]; then
            echo "NIC masih tidak terdeteksi. Pastikan driver sesuai."
            return
        fi
    fi

    for NIC in $NIC_LIST; do
        echo "Mengaktifkan interface $NIC..."
        ip link set "$NIC" up
    done
    echo "Semua NIC kabel diaktifkan."
}

# Cek parameter
if [ "$1" == "disable" ]; then
    disable_nic
elif [ "$1" == "enable" ]; then
    enable_nic
else
    echo "Gunakan: $0 [disable|enable]"
    exit 1
fi

