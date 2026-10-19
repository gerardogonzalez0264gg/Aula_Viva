# Se conecta al cluster usando tu archivo kubeconfig
provider "kubernetes" {
  config_path = var.kubeconfig_path
}

# Crea el espacio (namespace) de AulaViva
resource "kubernetes_namespace" "aulaviva" {
  metadata {
    name = "${var.namespace}-tf"
    labels = {
      proyecto = "aulaviva"
      ambiente = var.ambiente
    }
  }
}

# Secreto de ejemplo con valores FALSOS (se reemplazan fuera de Git)
resource "kubernetes_secret" "aulaviva_secretos" {
  metadata {
    name      = "aulaviva-secrets-placeholder"
    namespace = kubernetes_namespace.aulaviva.metadata[0].name
  }

  data = {
    JWT_SECRET  = "CAMBIAR-ESTE-VALOR"
    LLM_API_KEY = "CAMBIAR-ESTE-VALOR"
  }
}
