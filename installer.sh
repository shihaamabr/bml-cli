#!/bin/bash
cd /tmp/
git clone https://github.com/shihaamabr/bml-cli.git
mkdir -p /opt/sar/bml-cli/
mv bml-cli/* /opt/sar/bml-cli/
echo "#!/bin/bash" > /usr/bin/bml-cli
echo "source /opt/sar/bml-cli/bml-cli" >> /usr/bin/bml-cli
chmod 755 /usr/bin/bml-cli
rm -rf bml-cli/
echo "Installation Complete"
