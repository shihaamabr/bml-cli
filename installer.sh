#!/bin/bash
echo "Checking for curl..."
if command -v curl > /dev/null; then
echo "Detected curl..."
else
echo "Installing curl"
apt-get install -y gnupg

echo "Checking for jq..."
if command -v jq > /dev/null; then
echo "Detected jq..."
else
echo "Installing jq"
apt-get install -y jq

echo "Checking for openssl..."
if command -v openssl > /dev/null; then
echo "Detected openssl"
else
echo "Installing openssl"
apt-get install -y openssl

echo "Checking for perl..."
if command -v perl > /dev/null; then
echo "Detected perl..."
else
echo "Installing perl"
apt-get install -y perl

cd /tmp/
git clone https://github.com/shihaamabr/bml-cli.git
mkdir -p /opt/sar/bml-cli/
mv bml-cli/* /opt/sar/bml-cli/
echo "#!/bin/bash" > /usr/bin/bml-cli
echo "source /opt/sar/bml-cli/bml-cli" >> /usr/bin/bml-cli
chmod 755 /usr/bin/bml-cli
rm -rf bml-cli/
echo "Installation Complete"
