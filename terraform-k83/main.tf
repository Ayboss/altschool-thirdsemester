//a Kubernetes cluster

# instance kubectl linkto the cluster run the kubernetes

resource "linode_lke_cluster" "lkecluster" {
    k8s_version = var.k8s_version
    label = var.label
    region = var.region
    tags = var.tags

    dynamic "pool" {
        for_each = var.pools
        content {
            type  = pool.value["type"]
            count = pool.value["count"]
        }
    }
}

//Export this cluster's attributes
output "kubeconfig" {
  value = linode_lke_cluster.lkecluster.kubeconfig
  sensitive = true
}

output "api_endpoints" {
  value = linode_lke_cluster.lkecluster.api_endpoints
}

output "status" {
  value = linode_lke_cluster.lkecluster.status
}

output "id" {
  value = linode_lke_cluster.lkecluster.id
}

output "pool" {
  value = linode_lke_cluster.lkecluster.pool
}