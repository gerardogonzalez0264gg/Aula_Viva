# Aqui se guarda el "estado" de Terraform en un bucket remoto (no en el computador).
# Asi todo el equipo ve lo mismo y se evitan choques.
# Cambia el nombre del bucket por uno real de tu cuenta de Google Cloud.
#
# Para probar SIN bucket (en tu computador) usa:  terraform init -backend=false
terraform {
  backend "gcs" {
    bucket = "aulaviva-tfstate-CAMBIAR"
    prefix = "aulaviva/dev"
  }
}
