#!/usr/bin/ruby -w
#coding: utf-8

def dec2bin(dec)
  bin = sprintf("%b", dec).to_s
  bin = "0"*(8-bin.length)+bin if bin.length !=8
  return bin 
end

interface_networks=%x[ip addr | grep 'global']

#присутствующие на интерфейсе сети
networks=[]
interface_networks.each_line{|line| networks << [line.slice(/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\/\d{1,2}/).slice(/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/), line.slice(/\/\d{1,2}/).slice(/\d{1,}/)]}

#проверка заполнения массива
#networks.each{|p| p.each{|a| print a+"\n"}}

#добавим тестовый адрес
networks << ["192.168.122.1", "23"]

#Заполняем networks = [[addr, mask, [1OCTET, 2OCTET, 3OCTET, 4OCTET]], ..............]
for iface in networks
   iface[2] = Net.new
   #разбиваем на октеты 
   1.upto(4){|octet| iface[2] << iface[0].sub(/(\d{1,})\.(\d{1,})\.(\d{1,})\.(\d{1,})/, "\\"+octet.to_s)}
   #октеты в бинырную СС:
   iface[3] = []
   0.upto(3){|octet| iface[3] << (dec2bin(iface[2][octet]))}
end

#проверка заполнения октетами в десятичной СС
#networks.each{|p| p[2].each{|a| print a+"\n"}}



__END__