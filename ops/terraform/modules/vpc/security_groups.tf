/* Default security group that allows inbound and outbound traffic from all instances in the VPC */
resource "aws_security_group" "default" {
  name   = "${var.env}_sg_default"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    self        = true
  }

  tags = {
    Environment = var.env
    Name        = "${var.env}-sg-default"
  }
}

resource "aws_security_group" "eks_workers" {
  name   = "${var.env}_sg_eks_workers"
  vpc_id = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = var.env
    Name        = "${var.env}-sg-eks-workers"
  }
}
