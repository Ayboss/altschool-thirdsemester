//a Kubernetes cluster

# instance kubectl linkto the cluster run the kubernetes

resource "linode_domain" "foobar" {
    type = "master"
    domain = "dudeyouhavenoidea.com"
    soa_email = "bamiayo90@gmail.com"
    tags = ["foo", "bar"]
}

resource "linode_domain_record" "result" {
    domain_id = linode_domain.foobar.id
    name = "result"
    record_type = "AAAA"
    target = var.externalip
}

resource "linode_domain_record" "voting" {
    domain_id = linode_domain.foobar.id
    name = "voting"
    record_type = "AAAA"
    target = var.externalip
}

resource "linode_domain_record" "minisock" {
    domain_id = linode_domain.foobar.id
    name = "minisock"
    record_type = "AAAA"
    target = var.externalip
}