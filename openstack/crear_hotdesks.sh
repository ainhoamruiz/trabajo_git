#!/bin/bash

echo "Creando las 8 VMs para Hot-Desks (Forzando disco)..."

for i in {1..8}; do
  virt-install \
    --name hotdesk-0$i \
    --memory 1024 \
    --vcpus 1 \
    --disk size=10,bus=virtio,format=qcow2 \
    --network network=red_internal,model=virtio \
    --os-variant ubuntu22.04 \
    --import \
    --noautoconsole \
    --check disk_size=off
  
  echo "Hot-desk 0$i forzado y creado."
done

echo "¡Todas las máquinas desplegadas!"
