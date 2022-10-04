resource "aws_iam_instance_profile" "s3_rds_profile" {
  name = "S3_RDS_Profile"
  role = aws_iam_role.EC2_S3_RDS.name
}


resource "aws_instance" "web_golang_bai3" {
  ami             = "ami-0ff89c4ce7de192ea"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.generated_key.key_name
  # security_groups = ["web_golang_bai3"]
  iam_instance_profile = aws_iam_instance_profile.s3_rds_profile.name
  user_data = file("script.bash")
  tags = {
    Name = "golang"
  }

  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.web_ssh.id]

  //Copy folder travel vào thư mục /home/ec2-user/
  provisioner "file" {
    source      = "./uploads3"
    destination = "/home/ec2-user"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./${var.keyname}.pem")
      host        = aws_instance.web_golang_bai3.public_ip
    }
  }
}