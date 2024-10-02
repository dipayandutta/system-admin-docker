Steps To Follow
-----------------------------------
STEP-01
-------------------
Install Nginx Web Application Server on private IP- 192.168.199.213 

STEP-02
--------------

NAT  192.168.199.213  This IP a to public IP

STEP-03 
---------------------
Check from Public Domain of nginx Accessability

STEP-04
--------------

Create the index.html file which is attached to this email 
containing Hyperlink of other private web hosting applications
FILE LOCATION -> /usr/share/nginx/html/index.html

<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to Landing Page</h1>
<p>This is Server01 -->
<a href="http://182.74.150.25/server1">Server01</a>
</br>
</p>
<p>This is Server02 -->
<a href="http://182.74.150.25/server2">Server02</a>
</br>
</p>
<p>This is Server03 -->
<a href="http://182.74.25/server2">Server03</a>
</br>
</body>
</html>

STEP-04
--------------

Now change the default.conf of the Nginx web application server

file location -> /etc/nginx/conf.d/default.conf

server {
   listen       80;
   listen  [::]:80;
   server_name  182.74.150.25;

   #access_log  /var/log/nginx/host.access.log  main;

   location / {
       root   /usr/share/nginx/html;
       index  index.html index.htm;
   }

   location /server1/ {
       valid_referers none blocked 192.168.199.213;
       if ($invalid_referer != "1"){
               return 403;
       }
       proxy_pass http://192.168.199.214/;
       proxy_redirect http://192.168.199.214/ /server1/;
       proxy_set_header Host $host;
       proxy_set_header X-Real-IP $remote_addr;
       proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
       proxy_set_header X-Forwarded-Proto $scheme;
   }

   location /server2/ {
       proxy_pass http://192.168.199.215/;
       proxy_redirect http://192.168.199.215/ /server2/;
       proxy_set_header Host $host;
   }

Full file in the attachment. 


