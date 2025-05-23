FROM amazonlinux:2

RUN yum update -y && \
    yum install -y httpd && \
    echo "WELLLLCUM BRO YOU HAVE A NICE HAIRS" > /var/www/html/index.html

EXPOSE 80 

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
