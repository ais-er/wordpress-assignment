resource "aws_security_group" "mysg" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id = "vpc-0fbb91e1a8275d08e"

  tags = var.sg_tags

dynamic "ingress" {
    for_each = [80, 443, 22]
    content {
        from_port = ingress.value
        to_port = ingress.value
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.mysg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_instance" "my-ec2" {
 ami           = var.ami_ec2
 instance_type = var.ins_type
 subnet_id = "subnet-0f55dad4103069f2c"
 key_name = "ssh-key"

 tags = var.ins_tags

 security_groups = [
 "sg-01d3c9f9dbdcbe40d"
]
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh-key"  
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDqeclxhsfInPYc+tzHVRtWMwTPTyNOnZ/D27UNXI8XLM7N+aaDEPfMmfh47hKL6oFXd8E6/x3fm4G8Q5JudEShcZERABRb8vjNqBPkM11iNPd6p82xosk3We8X4u5lJ+zr20kBka7idz7v86AnmcnL1+jsqghv9m/n6l24kvFyADpoq+mKbMlONgDR0JmGwtewDUXfS90gic6RvSS1doB5Xsh8o9cqS3r9khZrqTQkeeR3FY7jl+NSDZIeGbHmh4/zNj6TWwhTir2WWVvtW4bV5AsU8KGhpOy9s7yUaOrUaw5LLf/lGPT+WmAhGh+v3OeYkzMHyZXbBOP2wTTxNqNwWa67FFagiPu7lj0tcMMkkZWZnXMDOMJpZT9prIrqrUITHcO7bK8Gwr/l0MwpyT+PYMdRmL49APqpd43Pml0onF1zAU/FopBcy0Lf3B4CjAvf74H9U8+nj7E1OFnStkKnDEm4gpS7WeMnDH27rwtdusTTC5vz+dAyDuL9lT/sFR0= aisuluuerkulova@Aisuluus-MacBook-Pro.local"
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Security group for RDS"
  vpc_id = "vpc-0fbb91e1a8275d08e"
  
  tags = {
    Name = "rds-sg"
  }
}

resource "aws_security_group_rule" "mysql_ingress" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id = aws_security_group.rds_sg.id
  source_security_group_id = aws_security_group.mysg.id
}

resource "aws_db_instance" "db" {
  allocated_storage    = var.storage
  db_name              = var.db_name
  engine               = var.engine
  storage_type = var.st_type
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.wordpress-db-sg.id
}

resource "aws_db_subnet_group" "wordpress-db-sg" {
  name       = "wordpress-db-sg"
  subnet_ids = var.db_sub

  tags = {
    Name = "My DB subnet group"
  }
}