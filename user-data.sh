#!/bin/bash
# Update the system
yum update -y
# Install Apache web server
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Get a secure session token for IMDSv2 (Security Best Practice)
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Use the token to fetch the Instance ID and Availability Zone
ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/instance-id)
AZ=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/placement/availability-zone)

# Create the webpage with the dynamic data
echo "<html><body style='font-family: Arial; text-align: center; margin-top: 50px;'>" > /var/www/html/index.html
echo "<h1>Welcome to Pallavi's Portfolio</h1>" >> /var/www/html/index.html
echo "<h3>Server ID: <span style='color: blue;'>$ID</span></h3>" >> /var/www/html/index.html
echo "<h3>Data Center Zone: <span style='color: green;'>$AZ</span></h3>" >> /var/www/html/index.html
echo "<p>This page was generated automatically by an Auto-Scaling Group.</p>" >> /var/www/html/index.html
echo "</body></html>" >> /var/www/html/index.html