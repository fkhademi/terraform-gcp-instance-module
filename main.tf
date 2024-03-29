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
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network    = var.vpc
    subnetwork = var.subnet

    dynamic "access_config" {
      for_each = var.public_ip == true ? toset([1]) : toset([])
      content {
        nat_ip = google_compute_address.default[0].address
      }
    }
  }

  metadata_startup_script = var.cloud_init_data

  tags = ["allow-ssh-${var.name}", var.tags]
  metadata = {
    ssh-keys = "ubuntu:${var.ssh_key}"
  }
}

resource "google_compute_firewall" "fw" {
  name    = "allow-all-${var.name}"
  network = var.vpc

  allow {
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = [ ] #"allow-all-${var.name}"]
}
