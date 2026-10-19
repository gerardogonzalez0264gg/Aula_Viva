variable "kubeconfig_path" {
  description = "Ruta del archivo que dice a que cluster conectarse"
  type        = string
  default     = "~/.kube/config"
}

variable "namespace" {
  description = "Nombre del espacio de AulaViva en el cluster"
  type        = string
  default     = "aulaviva"
}

variable "ambiente" {
  description = "dev, stg o prod (un estado de Terraform por ambiente)"
  type        = string
  default     = "dev"
}
