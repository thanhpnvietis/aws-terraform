resource "aws_iam_instance_profile" "s3_rds_profile" {
  name = "S3_RDS_Profile_bai2"
  role = aws_iam_role.EC2_S3_RDS.name
}


resource "aws_instance" "web_golang" {
  ami             = "ami-0ff89c4ce7de192ea"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.generated_key.key_name
  security_groups = ["web_golang"]
  iam_instance_profile = aws_iam_instance_profile.s3_rds_profile.name
  user_data = file("script.bash")
  tags = {
    Name = "golang"
  }

  //Copy folder travel vào thư mục /home/ec2-user/
  provisioner "file" {
    source      = "./uploads3"
    destination = "/home/ec2-user"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./${var.keyname}.pem")
      host        = aws_instance.web_golang.public_ip
    }
  }
}