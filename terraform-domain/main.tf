//a Kubernetes cluster

# instance kubectl linkto the cluster run the kubernetes

resource "linode_domain" "foobar" {
    type = "master"
    domain = var.domainName
    soa_email = var.email
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

resource "linode_domain_record" "prometheus" {
    domain_id = linode_domain.foobar.id
    name = "prometheus"
    record_type = "AAAA"
    target = var.externalip
}

resource "linode_domain_record" "minisock" {
    domain_id = linode_domain.foobar.id
    name = "minisock"
    record_type = "AAAA"
    target = var.externalip
}