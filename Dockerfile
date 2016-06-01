FROM ubuntu:14.04


RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
RUN echo "deb http://download.mono-project.com/repo/debian wheezy-apache24-compat main" | sudo tee -a /etc/apt/sources.list.d/mono-xamarin.list
RUN apt-get update
RUN apt-get install -y nginx vim mono-complete mono-fastcgi-server4 mono-vbnc


COPY . /app
WORKDIR /app

RUN sed -i 6d /etc/nginx/fastcgi_params
RUN echo 'fastcgi_param  PATH_INFO "";' >> /etc/nginx/fastcgi_params
RUN echo "fastcgi_param  SCRIPT_FILENAME \$document_root\$fastcgi_script_name;" >> /etc/nginx/fastcgi_params

RUN mkdir -p /var/log/mono
RUN touch /var/log/mono/fastcgi.log
RUN chmod 0777 /var/log/mono/fastcgi.log

RUN rm -r /etc/nginx/sites-enabled/* \
    && ln -sf /dev/stdout /var/log/nginx/asp_access.log \
    && ln -sf /dev/stderr /var/log/nginx/asp_error.log

RUN apt-get clean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/* /usr/src/*

CMD service nginx start && fastcgi-mono-server4 /applications=/:/app/ /socket=tcp:127.0.0.1:9000 /logfile=/var/log/mono/fastcgi.log /printlog=True

#CMD sudo nginx -g "daemon off;"
