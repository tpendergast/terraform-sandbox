
variable "mysql_host" {
  type        = string
  default     = "{ '1.2.3.4' => 3306 }"
}
variable "mysql_morpheus_db" {
  type        = string
  default     = "my_morpheus_db"
}

variable "mysql_morpheus_db_user" {
  type        = string
  default     = "my_morpheus_db_user"
}

variable "mysql_morpheus_password" {
  type        = string
  default     = "my_morpheus_password"
}


