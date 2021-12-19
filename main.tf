resource "google_compute_address" "default" {
  count = var.public_ip ? 1 : 0
  name  = "${var.name}-ip"
}

resource "google_compute_instance" "instance" {
  name         = "${var.name}-srv"
  machine_type = var.instance_size
  zone         = "${var.region}-${var.zone}"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  network_interface {
    network    = var.vpc
    subnetwork = var.subnet

    access_config {
      nat_ip = var.public_ip ? google_compute_address.default[0].address : null
    }
  }

  metadata_startup_script = "sudo apt-get update && sudo apt-get install iperf3 -y"

  tags = ["allow-ssh-${var.name}"]
  metadata = {
    ssh-keys = "ubuntu:${var.ssh_key}"
  }
}

resource "google_compute_firewall" "fw" {
  name    = "allow-ssh-${var.name}"
  network = var.vpc

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "5001", "5201"]
  }

  allow {
    protocol = "udp"
    ports    = ["5001", "5201"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-ssh"]
}
