#resource "aws_iam_role" "demo" {
 # name = "eks-cluster-demo"

  #assume_role_policy = <<POLICY
#{
 # "Version": "2012-10-17",
  #"Statement": [
    #{
      #"Effect": "Allow",
      #"Principal": {
       # "Service": "eks.amazonaws.com"
      #},
     # "Action": "sts:AssumeRole"
    #}
  #]
#}
#POLICY
#}

#resource "aws_iam_role_policy_attachment" "demo-AmazonEKSClusterPolicy" {
#  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#  role       = aws_iam_role.demo.name
#}

#resource "aws_eks_cluster" "demo" {
#  name     = "demo"
#  role_arn = aws_iam_role.demo.arn

  #vpc_config {
   # subnet_ids = [
    #  aws_subnet.private-us-east-1a.id,
    #  aws_subnet.private-us-east-1b.id,
     # aws_subnet.public-us-east-1a.id,
     # aws_subnet.public-us-east-1b.id
    #]
  #}

  #depends_on = [aws_iam_role_policy_attachment.demo-AmazonEKSClusterPolicy]
#}

################################nodes############################################
#resource "aws_iam_role" "nodes" {
#  name = "eks-node-group-nodes"

 # assume_role_policy = jsonencode({
  #  Statement = [{
   #   Action = "sts:AssumeRole"
    #  Effect = "Allow"
     # Principal = {
     #   Service = "ec2.amazonaws.com"
      #}
    #}]
    #Version = "2012-10-17"
  #})
#}

#resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
 # policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
 # role       = aws_iam_role.nodes.name
#}

#resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
#  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#  role       = aws_iam_role.nodes.name
#}

#resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
#  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#  role       = aws_iam_role.nodes.name
#}

#resource "aws_eks_node_group" "private-nodes" {
#  cluster_name    = aws_eks_cluster.demo.name
 # node_group_name = "private-nodes"
 # node_role_arn   = aws_iam_role.nodes.arn

  #subnet_ids = [
   # aws_subnet.private-us-east-1a.id,
  #  aws_subnet.private-us-east-1b.id
  #]

  #capacity_type  = "ON_DEMAND"
 # instance_types = ["t3.small"]

 # scaling_config {
  #  desired_size = 2
   # max_size     = 2
  #  min_size     = 1
  #}
  #}
