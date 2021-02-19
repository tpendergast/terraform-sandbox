variable "elastic_auth_user" {
  description = "Elastic database user" 
  type        = string
  default     = "my_auth_user"
}

variable "elastic_auth_password" {
  description = "Elastic database password" 
  type        = string
  default     = "my_auth_password_zzz"
}

variable "elastic_cluster" {
  description = "Elastic cluster  port" 
  type        = string
  default     = "my_esclustername"
}

variable "elastic_use_tls" {
  description = "Elastic TLS on/off boolean flag"
  type = bool
  default = true
}

variable "elastic_es_hosts" {
  description = "Elastic server list"
  type = string
  default = "{ '2.3.4.5' => 9200, '4.5.6.7' => 9200', '6.7.8.9' => 9200 }"
}

