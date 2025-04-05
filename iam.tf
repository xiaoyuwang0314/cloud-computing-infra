# resource "aws_iam_role" "cw_agent_role" {
#   name = "CloudWatchAgentRole"
#
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Action    = "sts:AssumeRole"
#       Effect    = "Allow"
#       Principal = { Service = "ec2.amazonaws.com" }
#     }]
#   })
# }
#
# resource "aws_iam_instance_profile" "cw_agent_instance_profile" {
#   name = "CloudWatchAgentInstanceProfile"
#   role = aws_iam_role.cw_agent_role.name
# }
#
# # CloudWatchAgentServerPolicy
# resource "aws_iam_role_policy_attachment" "cw_agent_policy" {
#   role       = aws_iam_role.cw_agent_role.name
#   policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
# }
#
# # AmazonSSMManagedInstanceCore
# resource "aws_iam_role_policy_attachment" "ssm_policy" {
#   role       = aws_iam_role.cw_agent_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
# }