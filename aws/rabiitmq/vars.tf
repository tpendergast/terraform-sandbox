variable "rabbitmq_vhost" {
  description = "RabbitMQ vhost" 
  type        = string
  default     = "my_vhost"
}

variable "rabbitmq_queue_user" {
  description = "RabbitMQ queue user" 
  type        = string
  default     = "my_queue_user"
}

variable "rabbitmq_queue_user_password" {
  description = "RabbitMQ queue password" 
  type        = string
  default     = "my_queue_user_password"
}

variable "rabbitmq_port" {
  description = "RabbitMQ port" 
  type        = number
  default     = 5672 
}

variable "rabbitmq_host" {
  description = "RabbitMQ Host"
  type = string
  default = "2.3.4.5" 
}

variable "rabbitmq_heartbeat" {
  description = "RabbitMQ heartbeat"
  type = number
  default = 50 
}

