variable vpc_cidr {
    type = string
    description = "cidr block for myvpc1"
}

variable vpc_tags {
    type = map(string)
}

variable igw_tags {
    type = map(string)
}

variable rt_cidr {
    type = string
}

variable pubrt_tags {
    type = map(string)
}

variable pubsub1_cidr {
    type = string
}

variable pubsub1_tags {
    type = map(string)
}

variable pubsub2_cidr {
    type = string
}

variable pubsub2_tags {
    type = map(string)
}

variable pubsub3_cidr {
    type = string
}

variable pubsub3_tags {
    type = map(string)
}

variable privsub1_cidr {
    type = string
}

variable privsub1_tags {
    type = map(string)
}

variable privsub2_cidr {
    type = string
}

variable privsub2_tags {
    type = map(string)
}

variable privsub3_cidr {
    type = string
}

variable privsub3_tags {
    type = map(string)
}