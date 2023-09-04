provider "aws" {
  region = var.region
}


resource "aws_instance" "instance" {
  for_each = aws_subnet.subnet

  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.instance.id]
  subnet_id       = each.value.id
  key_name        = var.key_name

  ebs_block_device {
    device_name = local.block_device_name
    volume_size = 2
  }

  tags = {
    Name = "instance-${each.value.id}"
  }
}



resource "aws_efs_file_system" "fs" {
  tags = {
    Name = local.filesystem_name
  }
}

resource "aws_efs_mount_target" "fs" {
  for_each        = aws_subnet.subnet
  file_system_id  = aws_efs_file_system.fs.id
  subnet_id       = each.value.id
  security_groups = [aws_security_group.fs.id]
}


resource "local_file" "inventory" {
  filename = "./playbook/inventory"
  content  = <<-EOF
  %{for k, v in aws_subnet.subnet~}
  ${aws_instance.instance[k].public_dns} ansible_ssh_user=ec2-user mount_target=${aws_efs_mount_target.fs[k].mount_target_dns_name} file_name=${aws_instance.instance[k].id}-file
  %{endfor~}
  EOF

  depends_on = [aws_efs_mount_target.fs, aws_instance.instance]
}

resource "local_file" "cfg" {
  filename = "./playbook/ansible.cfg"
  content  = <<-EOF
    [defaults]
    inventory = inventory
    private_key_file = ${var.key_path}
    host_key_checking = False
  EOF

  depends_on = [aws_efs_mount_target.fs, aws_instance.instance]
}


resource "null_resource" "ansible" {
  provisioner "local-exec" {
    command = "cd ./playbook && ansible-playbook main.yml"
  }
  depends_on = [local_file.inventory, local_file.cfg]
}
