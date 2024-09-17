
resource "nutanix_virtual_machine" "test" {
  name                 = "test"
  cluster_name         = "lu650.lalux.local"
  num_vcpus_per_socket = 1
  num_sockets          = 1
  memory_size_mib      = 2048

  disk_list {
    data_source_reference = {
      kind = "image"
      name = "rhel8-dc1"
    }
  }

  disk_list {
    disk_size_mib = 10240
  }

  nic_list {
    subnet_name = "New_PROD 192.168.25.x"
  }

  guest_customization_cloud_init_user_data = base64encode(<<-EOF
    #cloud-config
    hostname: test
    fqdn: test.example.com
    manage_etc_hosts: true
    users:
      - name: adminuser
        sudo: ALL=(ALL) NOPASSWD:ALL
        groups: users, admin
        home: /home/adminuser
        shell: /bin/bash
        lock_passwd: false
    ssh_pwauth: true
    disable_root: false
    chpasswd:
      list: |
        adminuser:password
      expire: false
    packages:
      - qemu-guest-agent
    runcmd:
      - systemctl start qemu-guest-agent
      - systemctl enable qemu-guest-agent
  EOF
  )
}
