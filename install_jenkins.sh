echo "Installing Dependencies for Jenkins"

sudo dnf -y install java-1.8.0-openjdk-devel wget firewalld

echo "Add Jenkins Software Repository"

sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key



sudo dnf update -y

echo "Starting Firewall Service"

sudo systemctl start firewalld
sudo systemctl enable firewalld

echo "Install Jenkins on CentOS 8"

sudo dnf -y install jenkins

echo "Start Jenkins Service"

sudo systemctl start jenkins
sudo systemctl enable jenkins

echo "Set Firewall to Allow Jenkins"

sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp

sudo firewall-cmd --reload

echo "Run and Set up Jenkins on http://your_domain:8080:
