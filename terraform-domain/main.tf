//a Kubernetes cluster

# instance kubectl linkto the cluster run the kubernetes

resource "linode_domain" "foobar" {
    type = "master"
    domain = "dudeyouhavenoidea.com"
    soa_email = "bamiayo90@gmail.com"
    tags = ["foo", "bar"]
}

resource "linode_domain_record" "foobar" {
    domain_id = linode_domain.foobar.id
    name = "blog"
    record_type = "AAAA"
    target = var.externalip
}

resource "linode_domain_record" "foobar2" {
    domain_id = linode_domain.foobar.id
    name = "shop"
    record_type = "AAAA"
    target = var.externalip
}