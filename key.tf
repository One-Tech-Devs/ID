resource "aws_key_pair" "onetech_keypair" {
  key_name   = "onetech_keypair"
  public_key = file("~/.ssh/id_ed25519.pub")
}

