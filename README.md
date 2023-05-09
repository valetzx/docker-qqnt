# docker-qqnt

在 Docker 中运行 QQNT 官方客户端

[GitHub](https://github.com/ilharp/docker-qqnt)
|
[GitHub Container Registry](https://github.com/ilharp/docker-qqnt/pkgs/container/docker-qqnt)
|
[Docker Hub](https://hub.docker.com/r/ilharp/qqnt)

## 使用

### 在线尝试

<a href="https://labs.play-with-docker.com/?stack=https://raw.githubusercontent.com/ilharp/docker-qqnt/master/docker-compose.yml" target="_blank"><img src="https://raw.githubusercontent.com/play-with-docker/stacks/master/assets/images/button.png" alt="Try in PWD" height="37"/></a>

### 使用 Docker

```sh
docker run --rm -it --security-opt seccomp=unconfined -p 6080:80 -p 5901 -e VNC_PASSWD=password ilharp/qqnt
```

### 使用 Docker Compose

```sh
docker compose up
```

### 使用 Docker Swarm

```sh
docker stack deploy --compose-file docker-compose.yml qqnt
```

### 使用浏览器连接

在浏览器中打开 [`http://localhost:6080`](http://localhost:6080) 然后输入密码 `password` 登录。

### 使用 VNC Viewer 连接

```sh
vncviewer :1 # 会连接到 127.0.0.1:5901
```

## 进入容器

进入容器（启动服务）：

```sh
docker run --rm -it -p 6080:80 -p 5901 -e VNC_PASSWD=password ilharp/qqnt /sbin/my_init -- bash -l
```

进入容器（不启动任何服务）：

```sh
docker run --rm -it -p 6080:80 -p 5901 -e VNC_PASSWD=password ilharp/qqnt bash
```

## 配方

### 持久化

- 持久化数据： `/root/.config/QQ`
- 持久化登录信息： `/root/.config/QQ/global/nt_db`

## 开发

先创建一个 builder：

```sh
docker buildx create --name container --driver=docker-container
```

构建镜像：

```sh
BUILD_DOCKER_BUILDER=container ./build.sh
```

## :warning: 免责声明 :warning:

本项目仅供学习研究使用。

## 许可

[MIT](https://github.com/ilharp/docker-qqnt/blob/master/LICENSE)
