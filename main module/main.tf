provider "aws" {
  region = "us-east-1"
}

module "vpc" {
    source = "../child modules/networking"
    vpc_cidr = "10.45.0.0/16"
    vpc_tags = {
        Name = "wordpress-vpc"
        Comment = "Terraform"
    }

    igw_tags = {
        Name = "wordpress_igw"
        Comment = "Terraform"
    }

    rt_cidr = "0.0.0.0/0"
    pubrt_tags = {
        Name = "wordpess-rt"
        Comment = "Terraform"
    }

    pubsub1_cidr = "10.45.15.0/24"
    pubsub1_tags = {
        Name = "pub_sub1"
    }

    pubsub2_cidr = "10.45.30.0/24"
    pubsub2_tags = {
        Name = "pub_sub2"
    }

    pubsub3_cidr = "10.45.45.0/24"
    pubsub3_tags = {
        Name = "pub_sub3"
    }

    privsub1_cidr = "10.45.60.0/24"
    privsub1_tags = {
        Name = "priv_sub1"
    }

    privsub2_cidr = "10.45.75.0/24"
    privsub2_tags = {
        Name = "priv_sub2"
    }

    privsub3_cidr = "10.45.90.0/24"
    privsub3_tags = {
        Name = "priv_sub3"
    }
}

output vpc_id {
    value = module.vpc.vpc_id
    sensitive = false
    description = "my vpc id output"
    depends_on = []
}



module "servers" {
    source = "../child modules/servers"
    sg_name = "wordpress-sg"
    sg_description = "SG to allow inbound http, https, ssh traffic"

    sg_tags = {
        Name = "wordpress-sg"
        Comment = "Terraform"
    }

    ami_ec2 = "ami-0cf10cdf9fcd62d37"
    ins_type = "t2.micro"

    ins_tags = {
        Name = "wordpress-ec2"
        Comment = "Terraform"
    }

    storage = 20
    db_name = "wordpress"
    engine = "mysql"
    st_type = "gp2"
    instance_class = "db.t2.micro"
    username = "admin"
    password = "adminadmin"

    db_sub = ["subnet-027c927fd213fbe38", "subnet-087ad3bb9091a219f", "subnet-01c0d74abb4cda0f3"]
}