resource "template_file" "jump_host" {
  template               = "${file("cloudinit/default.yml")}"

  vars {
    puppet_env           = "${var.puppet_env}"
    puppet_agent_version = "${var.puppet_agent_version}"
    hostname             = "${var.vdc}-jump0${count.index+1}"
  }
}

resource "template_file" "puppetdb" {
  template               = "${file("cloudinit/default.yml")}"
  count                  = "${length( split( ",", lookup( var.azs, var.region ) ) )}"

  vars {
    puppet_env           = "${var.puppet_env}"
    puppet_agent_version = "${var.puppet_agent_version}"
    hostname             = "${var.vdc}-puppetdb0${count.index+1}"
  }
}

resource "template_file" "nginx" {
  template               = "${file("cloudinit/default.yml")}"
  count                  = "${length( split( ",", lookup( var.azs, var.region ) ) )}"

  vars {
    puppet_env           = "${var.puppet_env}"
    puppet_agent_version = "${var.puppet_agent_version}"
    hostname             = "${var.vdc}-nginx0${count.index+1}"
  }
}
