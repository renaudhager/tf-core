#
# Bucket S3 to store TF remote state
#
resource "aws_s3_bucket" "remote_state_bucket" {
  bucket = "${var.owner}-tf-state-${var.region}"
  region = "${var.region}"
  versioning {
        enabled = true
    }
  tags {
      Name = "${var.owner}-tf-state-${var.region}"
      owner = "${var.owner}"
  }
}
