# AdminSys-ft_server
ft_server project of 42 school

commands:
sudo service nginx stop
docker build . -t test 
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)
docker run --name tester -it --rm -p 80:80 -p 443:443 test 
ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'
du
df

77  docker build . -t toto
  678  docker run -it -p 80:80 -p 443:443 toto
  679  docker -e "index=on" run -it -p 80:80 -p 443:443 toto
  680  docker run -e "autoindex off" -it -p 80:80 -p 443:443 toto\n
  681  docker run -e "autoindex on" -it -p 80:80 -p 443:443 toto\n
  682  vim srcs/default
  683  docker build . -t toto
  684  docker run -e "autoindex on" -it -p 80:80 -p 443:443 toto\n
  685  docker run -e "autoindex=on" -it -p 80:80 -p 443:443 toto\n
  686  docker run -e "index=on" -it -p 80:80 -p 443:443 toto\n
  687  docker run -e "index on" -it -p 80:80 -p 443:443 toto\n

index auto on/off:
