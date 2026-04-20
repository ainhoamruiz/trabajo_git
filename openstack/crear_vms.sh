#!/bin/bash

#función creadora
crear_vm() {
    NOMBRE=$1
    RED=$2
    RAM=$3
    
    echo "Creando $NOMBRE en la red $RED..."
    sudo qemu-img create -f qcow2 -b /var/lib/libvirt/images/ubuntu-master.qcow2 -F qcow2 /var/lib/libvirt/images/${NOMBRE}.qcow2 20G > /dev/null
    sudo virt-install --name $NOMBRE --memory $RAM --vcpus 1 \
      --disk /var/lib/libvirt/images/${NOMBRE}.qcow2,device=disk,bus=virtio \
      --os-variant ubuntu22.04 --network network=$RED --import --noautoconsole
}

echo "=== DESPLEGANDO INFRAESTRUCTURA MAIN ==="
crear_vm "balanceador" "red_main" 1024
crear_vm "web-01" "red_main" 1024
crear_vm "web-02" "red_main" 1024

echo "=== DESPLEGANDO INFRAESTRUCTURA INTERNAL ==="
crear_vm "master-01" "red_internal" 2048
crear_vm "master-02" "red_internal" 2048
crear_vm "worker-01" "red_internal" 2048
crear_vm "worker-02" "red_internal" 2048
crear_vm "bd" "red_internal" 2048
crear_vm "monitorizacion" "red_internal" 1024

echo "Infraestructura base completada"
