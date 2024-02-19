variable sg_name {
    type = string
}

variable sg_description {
    type = string
}

variable sg_tags {
    type = map(string)
}

variable ami_ec2 {
    type = string
}

variable ins_type {
    type = string
}

variable ins_tags {
    type = map(string)
}

variable storage {
    type = number
}

variable db_name {
    type = string
}

variable engine {
    type = string
}

variable instance_class {
    type = string
}

variable username {
    type = string
}

variable password {
    type = string
}

variable st_type {
    type = string
}

variable db_sub {
    type = list(string)
}