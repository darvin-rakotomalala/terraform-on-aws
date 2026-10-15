#!/bin/bash
sudo apt-get update
sudo apt-get install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
echo '<!doctype html>
<html lang="en"><h1>Home page!</h1></br>
<h3>(Instance A)</h3>
</html>' | sudo tee /var/www/html/index.html