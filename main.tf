variable "path" {
  type = string
}

data "external" "hash" {
  program = ["python3", "${path.module}/hash.py"]

  query = {
    path = var.path
  }
}

output "result" {
  value = data.external.hash.result["result"]
}
