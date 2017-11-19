把 
FROM golang:1.7.1-alpine修改成  FROM golang:latest

这样编译出来的 Linux ngrok 客户端支持更多版本的Linux 



# DOCKER NGROK IMAGE

## BUILD IMAGE

```linux
git clone https://github.com/hteen/docker-ngrok.git
cd docker-ngrok
docker build -t hteen/ngrok .
```

## RUN
* you must mount your folder (E.g `/data/ngrok`) to container `/myfiles`
* if it is the first run, it will generate the binaries file and CA in your floder `/data/ngrok`

```linux
docker run -idt --name ngrok-server \
-v /data/ngrok:/myfiles \
-e DOMAIN='tunnel.hteen.cn' hteen/ngrok /bin/sh /server.sh
```



假如你有 xxx.com 这个域名。
你拿出ngrok.xxx.com这个子域去做映射
需要在 dns 服务商那里把
为ngrok.xxx.com增加一条A记录，指向vps的ip。
并为*.ngrok.xxx.com增加一条A记录，也指向vps的ip。

生成并替换源码里默认的证书，注意域名修改为你自己的。（之后编译出来的服务端客户端会基于这个证书来加密通讯，保证了安全性）
每次生成的 客户端文件都要把最新的 客户端执行文件下载回来 在用  服务端和客户端都是一一对应的

全部客户端文件都在 /data/ngrok





docker run -idt --name ngrok-server --net=host -v /data/ngrok:/myfiles -e DOMAIN='ngrok.nb03.com' hteen/ngrok /bin/sh /server.sh


docker run -idt --name ngrok-server \
-p 80:80 -p 443:443 -p 4443:4443 \
-v /data/ngrok:/myfiles \
-e DOMAIN='nb03.com' hteen/ngrok /bin/sh /server.sh




客户端启动
ngrok.exe  -config=ngrok.cfg   start  tcp2

tcp2为 配置文件设置的模块名字

ngrok.exe  -config=ngrok.cfg   -proto=tcp 3389   这样就直接生成一个随机端口链接本地的3389端口

ngrok.exe  -config=ngrok.cfg   -proto=tcp 192.168.1.1:3389

ngrok.exe  -config=ngrok.cfg   -subdomain=a 192.168.1.1:80  这样分配一个 a 的 三级域名
