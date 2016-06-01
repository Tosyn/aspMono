# aspMono
Sample ASP application on Linux using Mono

Usage: This instruction assumes you have docker installed and working

###### clone repo
git clone https://github.com/Tosyn/aspMono.git

###### create docker image
cd aspMono
docker build -t aspapp .

###### start application
docker-compose up

###### update host machine etc host file : add text below
asp.dev

##### Click link below to view in browser
http://asp.dev:8181/
