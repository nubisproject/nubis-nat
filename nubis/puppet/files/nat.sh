#!/bin/bash
# 1. Instance should be in an Availability Autoscaling group with min/max size of 1
#    Example Autoscaling launch configuration:
#       aws autoscaling create-auto-scaling-group --auto-scaling-group-name ha-nat-asg\
#           --launch-configuration-name ha-nat-launch --min-size 1 --max-size 1\
#           --vpc-zone-identifier subnet-xxxxxxxx
#
# 2. AWS CLI version 1.2.2 or higher. By default, script will update instance to the latest version.
# 3. Private subnets must be tagged with tag Name=network and Value=private. Case IS sensitive.
# 4. IAM EC2 Role must be applied to instance:
#
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Action": [
#           "ec2:DescribeInstances",
#           "ec2:ModifyInstanceAttribute",
#           "ec2:DescribeSubnets",
#           "ec2:DescribeRouteTables",
#           "ec2:CreateRoute",
#           "ec2:ReplaceRoute"
#       ],
#       "Resource": "*"
#     }
#   ]
# }

# Enable for debugging
# set -x

. /usr/local/lib/util.sh

log "Beginning Port Address Translator (PAT) configuration..."
log "Determining the MAC address on eth0..."
ETH0_MAC=$(cat /sys/class/net/eth0/address) ||
    die "Unable to determine MAC address on eth0."
log "Found MAC ${ETH0_MAC} for eth0."

VPC_CIDR_URI="http://169.254.169.254/latest/meta-data/network/interfaces/macs/${ETH0_MAC}/vpc-ipv4-cidr-block"
log "Metadata location for vpc ipv4 range: ${VPC_CIDR_URI}"

ENI_ID_URI="http://169.254.169.254/latest/meta-data/network/interfaces/macs/${ETH0_MAC}/interface-id"
log "Metadata for location of eth0 ENI id: ${ENI_ID_URI}"

VPC_CIDR_RANGE=$(curl --retry 3 --silent --fail ${VPC_CIDR_URI})
if [ $? -ne 0 ]; then
    log "Unable to retrive VPC CIDR range from meta-data, using 0.0.0.0/0 instead. PAT may be insecure!"
    VPC_CIDR_RANGE="0.0.0.0/0"
else
    log "Retrieved VPC CIDR range ${VPC_CIDR_RANGE} from meta-data."
fi

log "Enabling PAT..."
sysctl -q -w net.ipv4.ip_forward=1 net.ipv4.conf.eth0.send_redirects=0 && (
    iptables -t nat -C POSTROUTING -o eth0 -s ${VPC_CIDR_RANGE} -j MASQUERADE 2> /dev/null ||
    iptables -t nat -A POSTROUTING -o eth0 -s ${VPC_CIDR_RANGE} -j MASQUERADE ) ||
        die

set -x
sysctl net.ipv4.ip_forward net.ipv4.conf.eth0.send_redirects
iptables -n -t nat -L POSTROUTING
set +x

log "Configuration of NAT/PAT complete."

log "Disabling SourceDestCheck"
ENI_ID=$(curl --retry 3 --silent --fail "${ENI_ID_URI}")
SOURCEDEST_CHECK=$(aws ec2 describe-network-interfaces --network-interface-ids "${ENI_ID}" --query 'NetworkInterfaces[].SourceDestCheck' --region "${REGION}" --output text)

# This needs to happen otherwise the NAT will not work
if [[ "${SOURCEDEST_CHECK}" != 'False' ]] || [[ "${SOURCEDEST_CHECK}" != 'false' ]]; then
    log "Setting SourceDestCheck to false"
    aws ec2 modify-network-interface-attribute --network-interface-id "${ENI_ID}" --no-source-dest-check --region "${REGION}" ||
        die "Unable to set SourceDestCheck to false"
fi
