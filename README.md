# 개발 워크스테이션 구축 미션

## 1. 프로젝트 개요

이 프로젝트는 터미널, Docker, Git/GitHub를 활용해 개발 워크스테이션 환경을 직접 구성하고 검증한 기록입니다.

학습 목표:
- 리눅스 CLI 기본 조작 익히기
- 파일/디렉토리 권한 이해하기
- Docker 설치 및 기본 운영 명령 익히기
- Dockerfile 기반 커스텀 이미지 만들기
- 포트 매핑, 바인드 마운트, 볼륨 영속성 확인하기
- Git 설정 및 GitHub 연동 확인하기

---

## 2. 실행 환경

- OS: `macOS`
- Shell: `bash zsh`
- Terminal: `Terminal`
- Docker: `OrbStack, Docker version 28.5.2`
- Git: `git version 2.53.0`

### 버전 확인 명령
```bash
% uname -a
Darwin /RELEASE_X86_64 x86_64
```
```bash
% git --version
git version 2.53.0
```
```bash
% git config --list
credential.helper=osxkeychain
user.name=raffi0922
user.email=*****@gmail.com
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
core.ignorecase=true
core.precomposeunicode=true
remote.origin.url=https://github.com/raffi0922/cds-w1-m1.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.main.remote=origin
branch.main.merge=refs/heads/main
branch.main.vscode-merge-base=origin/main
```
```bash
% docker --version
Docker version 28.5.2, build ecc6942
```
```bash
% echo $SHELL
/bin/zsh
```
```bash
% docker info
Client:
Version:    28.5.2
Context:    orbstack
```

---

## 3. 수행 체크리스트

- [x] 현재 위치 확인 및 디렉토리 이동
- [x] 파일/디렉토리 생성, 복사, 이동, 삭제
- [x] 숨김 파일 확인
- [x] 파일 내용 확인 및 빈 파일 생성
- [x] 파일/디렉토리 권한 확인 및 변경
- [x] Docker 버전 확인
- [x] Docker 데몬 동작 확인
- [x] `hello-world` 실행
- [x] `ubuntu` 컨테이너 실행 및 내부 명령 확인
- [x] Docker 이미지 목록 확인
- [x] 컨테이너 실행/중지/목록 확인
- [x] `docker logs`, `docker stats` 확인
- [x] Dockerfile 기반 커스텀 이미지 빌드
- [x] 포트 매핑 접속 확인
- [x] 바인드 마운트 반영 확인
- [x] Docker 볼륨 영속성 확인
- [x] Git 사용자 정보/기본 브랜치 설정
- [x] GitHub 저장소 연동

---

## 4. 터미널 조작 로그

### 4-1. 현재 위치 확인 / 목록 확인
```bash
% pwd
/Users/hyeonmo90922/proejct
% ls
README.md
# 숨김파일 포함
% ls -al 
total 24
drwxr-xr-x   4 hyeonmo90922  hyeonmo90922   128  7 29 15:17 .
drwxr-xr-x   5 hyeonmo90922  hyeonmo90922   160  7 29 15:41 ..
drwxr-xr-x  12 hyeonmo90922  hyeonmo90922   384  7 29 15:43 .git
-rw-r--r--@  1 hyeonmo90922  hyeonmo90922  8694  7 29 16:11 README.md
```

### 4-2. 디렉토리 이동 / 생성 / 복사 / 이름 변경 / 삭제
```bash
% mkdir cody # 생성
% cd cody # 디렉토리 이동
% touch cody.txt # 생성
% cp cody.txt cody2.txt # 복사
% mv cody.txt cody1.txt # 이름 변경
% ls     
cody1.txt	cody2.txt
% cp cody2.txt cody3.txt # 복사
% rm cody3.txt # 삭제
% mkdir sub # 디렉토리 생성
% ls
cody1.txt	cody2.txt	sub
% rm -r sub # 디렉토리 삭제
```

### 4-3. 파일 내용 확인 / 빈 파일 생성
```bash
% touch empty.txt # 빈 파일 생성
% echo "test" > empty.txt # 파일 내용 확인
% cat empty.txt 
test
```

---

## 5. 권한 실습

### 5-1. 파일 권한 확인 및 변경
소유자(user), 그룹(group), 다른사용자(others)
(7) = 읽기(4), 쓰기(2), 실행(1) 모든 권한
- `644 rw- r-- r--` : 소유자 수정가능, 나머지 읽기만
- `755 rwx r-x r-x` : 소유자 수정가능, 나머지 읽기+실행
대상 파일: `emmpty.txt`

```bash
% ls -l empty.txt # 644 
-rw-r--r--  1 hyeonmo90922  hyeonmo90922  5  7 29 16:59 empty.txt
% chmod 755 empty.txt # 권한 변경 755
% ls -l empty.txt    
-rwxr-xr-x  1 hyeonmo90922  hyeonmo90922  5  7 29 16:59 empty.txt
```

### 5-2. 디렉토리 권한 확인 및 변경
대상 디렉토리: `cody`

```bash
% ls -ld cody        
drwxr-xr-x  4 hyeonmo90922  hyeonmo90922  128  7 29 16:40 cody
% chmod 755 cody
% ls -ld cody
drwxr-xr-x  4 hyeonmo90922  hyeonmo90922  128  7 29 16:40 cody
```

---

## 6. Docker 설치 및 기본 점검

### 6-1. 버전 확인
```bash
% docker --version
Docker version 28.5.2, build ecc6942
% docker info     
Client:
 Version:    28.5.2
 Context:    orbstack
 Debug Mode: false
 Plugins:
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.29.1
    Path:     /Users/hyeonmo90922/.docker/cli-plugins/docker-buildx
  compose: Docker Compose (Docker Inc.)
    Version:  v2.40.3
    Path:     /Users/hyeonmo90922/.docker/cli-plugins/docker-compose
...(이하생략)
```

---

## 7. 컨테이너 실행 실습

### 7-1. hello-world 이미지 다운로드, 컨테이너 실행 및 내부 명령 실행

```bash
# hello-world 이미지 다운로드
% docker pull hello-world 
Using default tag: latest
latest: Pulling from library/hello-world
4f55086f7dd0: Pull complete 
Digest: sha256:c3cbe1cc1aa588a64951ac6286e0df7b27fe2e6324b1001c619bb358770c0178
Status: Downloaded newer image for hello-world:latest
docker.io/library/hello-world:latest
```

```bash
# hello-world 컨테이너 실행 및 내부 명령 실행
% docker run hello-world
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

### 7-2. nginx:alpine 이미지 다운로드, 컨테이너 실행 및 내부 명령 실행
```bash
# nginx:alpine 이미지 다운로드
% docker pull nginx:alpine
alpine: Pulling from library/nginx
55afa1ecc21d: Pull complete 
3cd534fe98c6: Pull complete 
1223f016b4e4: Pull complete 
62bec68d7c31: Pull complete 
46f977ee452f: Pull complete 
d0008c891db4: Pull complete 
390dc935348d: Pull complete 
46519e7231d2: Pull complete 
Digest: sha256:4a73073bd557c65b759505da037898b61f1be6cbcc3c2c3aeac22d2a470c1752
Status: Downloaded newer image for nginx:alpine
docker.io/library/nginx:alpine
```

```bash
# nginx:alpine 컨테이너 실행 및 내부 명령 실행
% docker run -d -p 8080:80 --name my-nginx nginx:alpine
22c9f60c5ca904dcf8a450c11bcd1808bcbb0c753eed83292f814067aa98c2c5
```

### 7-3. ubuntu 이미지 다운로드, 컨테이너 실행 및 내부 명령 실행
```bash
# ubuntu 이미지 다운로드
 % docker pull ubuntu                                
Using default tag: latest
latest: Pulling from library/ubuntu
ed819469700f: Pull complete 
a3679419df18: Pull complete 
Digest: sha256:3131b4cc82a783df6c9df078f86e01819a13594b865c2cad47bd1bca2b7063bb
Status: Downloaded newer image for ubuntu:latest
docker.io/library/ubuntu:latest
```

```bash
# ubuntu 컨테이너 실행 및 내부 명령 실행
hyeonmo90922@c6r4s8 cds-w1-m1 % docker run -it --name my-ubuntu ubuntu      
root@da6e4695b9cc:/# ls
bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@da6e4695b9cc:/# echo "hello docker"
hello docker
root@da6e4695b9cc:/# exit
exit
```

### 7-4. 이미지 / 컨테이너 상태 확인
```bash
% docker images                                     
REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
nginx         alpine    f0ba77f796e5   2 weeks ago    62.4MB
ubuntu        latest    de7345b16e94   2 weeks ago    100MB
hello-world   latest    e2ac70e7319a   4 months ago   10.1kB
% docker ps
CONTAINER ID   IMAGE          COMMAND                   CREATED         STATUS         PORTS                                     NAMES
22c9f60c5ca9   nginx:alpine   "/docker-entrypoint.…"   8 minutes ago   Up 8 minutes   0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   my-nginx
% docker ps -a                          
CONTAINER ID   IMAGE          COMMAND                   CREATED         STATUS                          PORTS                                     NAMES
da6e4695b9cc   ubuntu         "/bin/bash"               2 minutes ago   Exited (0) About a minute ago                                             my-ubuntu
22c9f60c5ca9   nginx:alpine   "/docker-entrypoint.…"   8 minutes ago   Up 8 minutes                    0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   my-nginx
```

### 7-5. attach / exec / 종료 차이 
📌 개념 정리
| 구분	| attach | exec |
|---|---|---|
| 목적	| 실행 중인 컨테이너의 표준입출력에 연결 |	컨테이너 내에서 새로운 프로세스 실행 |
| 상호작용|	메인 프로세스와 직접 상호작용	| 독립적인 새 프로세스 실행 |
| 종료 시|	메인 프로세스 종료 → 컨테이너 중지	| 새 프로세스만 종료 → 컨테이너 계속 실행 |
| 사용 사례	|로그 실시간 확인, 포그라운드 프로세스 모니터링	| 디버깅, 명령 실행, 셸 접속 |
| 위험도	| ⚠️ 높음 (실수로 종료 가능) |	✅ 안전함 |


🔴 attach 사용 (위험한 방식)

1️⃣ nginx:alpine 컨테이너 실행
```bash
% docker start my-nginx                                
my-nginx
```

2️⃣ 컨테이너 상태 확인
```bash
% docker ps
CONTAINER ID   IMAGE          COMMAND                   CREATED             STATUS         PORTS                                     NAMES
22c9f60c5ca9   nginx:alpine   "/docker-entrypoint.…"   About an hour ago   Up 7 seconds   0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   my-nginx
```

3️⃣ 컨테이너는 메인 프로세스 접속 후 중지
```bash
% docker attach my-nginx
***.***.***.* - - [03/Aug/2026:06:40:59 +0000] "GET / HTTP/1.1" 200 896 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36" "-"
2026/08/03 06:41:00 [error] 23#23: *1 open() "/usr/share/nginx/html/favicon.ico" failed (2: No such file or directory), client: ***.***.***.* server: localhost, request: "GET /favicon.ico HTTP/1.1", host: "localhost:8080", referrer: "http://localhost:8080/"
***.***.***.* - - [03/Aug/2026:06:41:00 +0000] "GET /favicon.ico HTTP/1.1" 404 555 "http://localhost:8080/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36" "-"
# Ctrl+C를 누르면...
^C2026/08/03 06:41:08 [notice] 1#1: signal 2 (SIGINT) received, exiting
2026/08/03 06:41:08 [notice] 1#1: exit
```

4️⃣ ⚠️ 문제점 발생!
```bash
% docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
# 컨테이너가 사라짐! (중지됨)
```
attach로 메인 프로세스에 연결됨
Ctrl+C를 누르면 메인 프로세스 자체가 종료됨
메인 프로세스 종료 → 컨테이너 자동 중지



🟢 exec 사용 (안전한 방식)
1️⃣ nginx:alpine 컨테이너 다시 실행
```bash
% docker start my-nginx 
my-nginx
```

```bash
% docker ps                                          
CONTAINER ID   IMAGE          COMMAND                   CREATED       STATUS          PORTS                                     NAMES
22c9f60c5ca9   nginx:alpine   "/docker-entrypoint.…"   2 hours ago   Up 2 seconds   0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   my-nginx
```

2️⃣ exec로 새 프로세스 실행 후 중지
```bash
 % docker exec my-nginx cat /var/log/nginx/access.log
^C%   
```

3️⃣  컨테이너는 여전히 실행 중
```bash
% docker ps                                         
CONTAINER ID   IMAGE          COMMAND                   CREATED       STATUS              PORTS                                     NAMES
22c9f60c5ca9   nginx:alpine   "/docker-entrypoint.…"   2 hours ago   Up About a minute   0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   my-nginx
# 상태: Up a minutes = 계속 실행 중! ✅
```

---

## 8. Dockerfile 기반 커스텀 이미지

### 8-1. nginx 커스텀 베이스 이미지
- 베이스 이미지: `nginx:alpine`
이유: 경량(42.5MB), 보안 업데이트 빠름, 웹 서버 기본 기능 포함
- 웹서버 `HTML 정적 파일 교체` `설정 파일 변경`
- 리눅스 `환경변수 추가` `헬스체크 추가`

### 8-2. 정적 콘텐츠 준비

```bash
% cat > site/index.html << 'EOF'
<html>
<meta charset="UTF-8">
🎉 NGINX 커스텀 이미지 성공!
이것은 바인드 마운트로 반영된 콘텐츠입니다.
호스트에서 파일을 수정하면 실시간으로 반영됩니다.
</html>
EOF
% cat site/index.html           
🎉 NGINX 커스텀 이미지 성공!
이것은 바인드 마운트로 반영된 콘텐츠입니다.
호스트에서 파일을 수정하면 실시간으로 반영됩니다.
```

### 8-3. 프로젝트 구조
```bash
project/
├── Dockerfile
├── site/
│   └── index.html
└── README.md
```

### 8-4. Dockerfile
```Dockerfile
% cat > Dockerfile << 'EOF'
FROM nginx:alpine

LABEL org.opencontainers.image.title="my-custom-nginx"
LABEL org.opencontainers.image.version="1.0"

#환경 변수 설정
ENV APP_ENV=development
ENV NGINX_PORT=80

#정적 콘텐츠 복사
COPY site/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
EOF
```

커스텀 포인트 설명:
|항목|목적|
|---|---|
|FROM nginx:alpine	| 경량 웹 서버 베이스|
|LABEL	| 이미지 메타데이터 추가|
|ENV	| 환경 변수로 설정 외부화|
|COPY site/|	호스트 콘텐츠를 컨테이너로 복사|
|HEALTHCHECK|	컨테이너 상태 자동 감시|
EXPOSE 80|	포트 문서화|

### 8-5. 빌드 명령
```bash
 % docker build -t my-custom-nginx:1.0 .
[+] Building 1.8s (7/7) FINISHED                                                                              docker:orbstack
...
 => => naming to docker.io/library/my-custom-nginx:1.0 
```

```bash
% docker images | grep my-custom-nginx
my-custom-nginx   1.0       5df2d5102d4e   51 seconds ago   62.4MB
```

### 8-6. 실행 명령 (포트 매핑) , 컨테이너 확인
```bash
# 실행 명령 (포트 매핑)
% docker run -d -p 8080:80 --name my-nginx-server my-custom-nginx:1.0
6d75e498e0d8bd0ea5c894d84bd64b793b47156aeeac572a216c0cc3d7814e67
```

```bash
# 컨테이너 확인
% docker ps
CONTAINER ID   IMAGE                 COMMAND                   CREATED          STATUS          PORTS                                     NAMES
6d75e498e0d8   my-custom-nginx:1.0   "/docker-entrypoint.…"   16 seconds ago   Up 15 seconds   0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   my-nginx-server
```

---

## 9. 포트 매핑 접속 증거

### 접속 확인 명령
```bash
% curl http://localhost:8080
🎉 NGINX 커스텀 이미지 성공!
이것은 바인드 마운트로 반영된 콘텐츠입니다.
호스트에서 파일을 수정하면 실시간으로 반영됩니다.
```

### 브라우저 접속 증거
- 접속 주소: `http://localhost:8080`
- ✅ 스크린샷  
![브라우저 접속: http://localhost:8080](./screenshot/9.browser.png)
---

### 로그 확인
```bash
% docker logs my-nginx-server
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
...
***.***.***.* - - [03/Aug/2026:08:33:18 +0000] "GET / HTTP/1.1" 200 174 "-" "curl/8.7.1" "-"
```

## 10. 바인드 마운트 검증


### 10-1. site/html 정적 웹페이지 복사
```bash
% cd ~
% cd mkdir site
% cp project/cds-w1-m1/site/index.html site/index.html
% cat ~/site/index.html
```

### 10-2. nginx:alpine 실행 명령
```bash
% dokcer start my-nginx
```
- 접속 주소: `http://localhost:8080`
- ✅ 스크린샷 nginx 웹페이지 내용 확인  
![브라우저 접속: http://localhost:8080](./screenshot/10-2.browser.png)

### 10-3. 로컬 정적웹 마운트 컨테이너 실행 명령
```bash
% docker run -d -p 8080:80 --name my-mount-nginx -v ~/site:/usr/share/nginx/html nginx:alpine
```
- 접속 주소: `http://localhost:8080`
- ✅ 스크린샷   ~/site/index.html 웹페이지 마운트 된 내용 확인
![브라우저 접속: http://localhost:8080](./screenshot/10-3.browser.png)


### 10-4. 컨테이너에서 마운트 확인
```bash
% docker exec my-mount-nginx ls -la /usr/share/nginx/html/
total 4
drwxr-xr-x    1 root     root            96 Aug  3 09:24 .
drwxr-xr-x    1 root     root             8 Jul 15 23:31 ..
-rw-r--r--    1 root     root           211 Aug  3 09:30 index.html
```

### 10-4. 호스트 변경 전/ 후 확인
호스트 파일 변경 전:
```bash
# 컨테이너 확인
% docker exec my-mount-nginx cat /usr/share/nginx/html/index.html
<html>
<meta charset="UTF-8">
🎉 NGINX 커스텀 이미지 성공!
이것은 바인드 마운트로 반영된 콘텐츠입니다.
호스트에서 파일을 수정하면 실시간으로 반영됩니다.
</html>%  
```

```bash
# curl 확인
% curl http://localhost:8080/ 
<html>
<meta charset="UTF-8">
🎉 NGINX 커스텀 이미지 성공!
이것은 바인드 마운트로 반영된 콘텐츠입니다.
호스트에서 파일을 수정하면 실시간으로 반영됩니다.
</html>%  
```

호스트 파일 변경:
```bash
% cat > site/index.html << 'EOF'
<html>
<meta charset="UTF-8">
🎉 NGINX 커스텀 이미지 성공!
이것은 바인드 마운트로 반영된 콘텐츠입니다.
호스트에서 파일을 수정하면 실시간으로 반영됩니다.
호스트파일을 추가로 수정했습니다.
</html>
EOF
% cat site/index.html           
🎉 NGINX 커스텀 이미지 성공!
이것은 바인드 마운트로 반영된 콘텐츠입니다.
호스트에서 파일을 수정하면 실시간으로 반영됩니다.
호스트파일을 추가로 수정했습니다.
```

호스트 파일 변경 후:
```bash
# 컨테이너 확인
% docker exec my-mount-nginx cat /usr/share/nginx/html/index.html
<html>
<meta charset="UTF-8">
🎉 NGINX 커스텀 이미지 성공!
이것은 바인드 마운트로 반영된 콘텐츠입니다.
호스트에서 파일을 수정하면 실시간으로 반영됩니다.
호스트파일을 추가로 수정했습니다.
</html>%  
```

```bash
# curl 확인
% curl http://localhost:8080/ 
<html>
<meta charset="UTF-8">
🎉 NGINX 커스텀 이미지 성공!
이것은 바인드 마운트로 반영된 콘텐츠입니다.
호스트에서 파일을 수정하면 실시간으로 반영됩니다.
호스트파일을 추가로 수정했습니다.
</html>%  
```

- 접속 주소: `http://localhost:8080`
- ✅ 스크린샷 nginx 웹페이지 내용 확인Í
![브라우저 접속: http://localhost:8080](./screenshot/10-4.browser.png)

---

## 11. Docker 볼륨 영속성 검증

### 11-1. data/test.txt 파일 생성
```bash
% cd ~/project/cds-w1-m1
% cd mkdir data
% touch data/test.txt
% cat data/test.txt
```

### 11-1. 볼륨 생성
```bash
% docker volume create my-volume
my-volume
% docker volume ls
DRIVER    VOLUME NAME
local     my-volume
```

### 11-2. 볼륨 상세 정보 확인
```bash
% docker volume inspect my-volume
[
    {
        "CreatedAt": "2026-08-03T20:34:42+09:00",
        "Driver": "local",
        "Labels": null,
        "Mountpoint": "/var/lib/docker/volumes/my-volume/_data",
        "Name": "my-volume",
        "Options": null,
        "Scope": "local"
    }
]
```


### 11-3. 볼륨 컨테이너 연결 실행 & 확인
```bash
% docker run -d --name volume-test -v my-volume:/data ubuntu sleep infinity
7c17bc706fe2ced2bcbb288ee52625c77711b40ebbdea8d5261e0db4886838ca
% docker ps
CONTAINER ID   IMAGE     COMMAND            CREATED         STATUS         PORTS     NAMES
7c17bc706fe2   ubuntu    "sleep infinity"   4 seconds ago   Up 4 seconds             volume-test
```

### 11-3. 데이터 저장 및 확인
```bash
% docker exec -it volume-test bash -lc 'echo "hello" > /data/test.txt && cat /data/test.txt'
hello
```

### 11-4. 볼륨 컨테이너 삭제 후 기존 볼륨 컨테이너 연결 후 실행
```bash
# 컨테이너 삭제 
% docker rm -f volume-test
volume-test
% docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

```bash
# 볼륨 컨테이너 연결 
% docker run -d --name volume-new -v my-volume:/data ubuntu sleep infinity
b66bf8bd98cec6f9b21867328b718055e72dac22a1ecf3503b697a64deb06eaf
% docker ps                                                               
CONTAINER ID   IMAGE     COMMAND            CREATED         STATUS         PORTS     NAMES
b66bf8bd98ce   ubuntu    "sleep infinity"   4 seconds ago   Up 3 seconds             volume-new
# 데이터 확인
% docker exec -it volume-new bash -lc 'cat /data/test.txt'
hello
```

---

## 12. Git 설정 및 GitHub 연동

### 12-1. Git 기본 설정
```bash
% git config --global user.name "raffi0922"
% git config --global user.email "***@gmail.com"
% git config --global init.defaultBranch main
% git config --list                        
credential.helper=osxkeychain
user.name=raffi0922
user.email=***@gmail.com
init.defaultbranch=main
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
core.ignorecase=true
core.precomposeunicode=true
remote.origin.url=https://github.com/raffi0922/cds-w1-m1.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.main.remote=origin
branch.main.merge=refs/heads/main
branch.main.vscode-merge-base=origin/main
```


### 12-2. 저장소 연동
- GitHub Repository: `https://github.com/raffi0922/cds-w1-m1.git`
- 원격 저장소 등록:
```bash
% git remote add origin https://github.com/raffi0922/cds-w1-m1.git
% git remote -v
origin	https://github.com/raffi0922/cds-w1-m1.git (fetch)
origin	https://github.com/raffi0922/cds-w1-m1.git (push)
```


### 12-3. VSCode GitHub 로그인 연동 증거
- VSCode GitHub 로그인 완료: `예`
- VSCode Source Control 연동 확인: `예`
- 스크린샷

![vscode_github](./screenshot/12-3.vscode_github.png)


---

## 13 보너스 과제 (선택)

### 13-1. Docker Compose 기초
- `docker-compose.yml`의 기본 구조를 학습하고, 단일 서비스를 Compose로 실행한다.
- 배움 포인트: 컨테이너 실행 명령이 “문서화된 실행 설정”으로 바뀌는 이유

```bash
# 파일 생성
% cat > docker-compose.yml << 'EOF'
version: '3.8'

services:
  web:
    build: .
    container_name: compose-web
    ports:
      - "8080:80"
    restart: unless-stopped
EOF
```

```bash
# 컨테이너 실행
 % docker-compose up -d
WARN[0000] /Users/hyeonmo90922/project/cds-w1-m1/docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion 
[+] Building 1.2s (9/9) FINISHED
...
 ✔ Container compose-web      Started   
```

```bash
# 컨테이너 확인
% docker ps        
CONTAINER ID   IMAGE           COMMAND                   CREATED              STATUS              PORTS                                     NAMES
cb5a0eb62405   cds-w1-m1-web   "/docker-entrypoint.…"   About a minute ago   Up About a minute   0.0.0.0:8080->80/tcp, [::]:8080->80/tcp   compose-web
```

```bash
# 웹 서버 확인
% curl http://localhost:8080/
<html>
<meta charset="UTF-8">
🎉 NGINX 커스텀 이미지 성공!
이것은 바인드 마운트로 반영된 콘텐츠입니다.
호스트에서 파일을 수정하면 실시간으로 반영됩니다.
</html>%   
```

```bash
# 로그 확인
% docker-compose logs -f web
WARN[0000] /Users/hyeonmo90922/project/cds-w1-m1/docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion 
compose-web  | /docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
```

```bash
# 컨테이너 중지
% docker-compose down
WARN[0000] /Users/hyeonmo90922/project/cds-w1-m1/docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion 
[+] Running 2/2
 ✔ Container compose-web      Removed                                                                                               0.4s 
 ✔ Network cds-w1-m1_default  Removed
% docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

📌 주요 개념
version: Compose 파일 형식 버전 (3.8 = Docker 19.03+)
services: 실행할 컨테이너들 정의
build: Dockerfile 경로 지정
ports: 포트 매핑 (호스트:컨테이너)
restart: 재시작 정책 (unless-stopped = 수동 중지 전까지 재시작)

📌 장점
- ✅ 설정이 문서화됨
- ✅ 재사용 가능
- ✅ 버전 관리 가능

### 13-2. Docker Compose 멀티 컨테이너
- 웹 서버 + (임의의 보조 서비스) 2개 이상을 Compose로 함께 실행한다.
- 컨테이너 간 네트워크 통신이 가능한지 확인한다.
- 배움 포인트: 네트워크/서비스 디스커버리 개념 맛보기




### 13-3. Compose 운영 명령어 습득
- `up`, `down`, `ps`, `logs`를 사용해 실행/종료/상태/로그를 관리한다.
- 배움 포인트: 운영 관점의 “상태 확인 루틴” 만들기

### 13-4. 환경 변수 활용
- Dockerfile 또는 Compose에서 환경 변수를 주입해 서버 포트/모드를 바꿔본다.
- 배움 포인트: 설정과 코드의 분리

### 13-5. GitHub SSH 키 설정
- HTTPS 대신 SSH로 푸시가 가능하도록 키를 등록하고 동작을 확인한다.
- 배움 포인트: 인증 방식 차이와 보안 습관

---


## 14. 트러블슈팅

### 이슈 1
- 문제: `바인드 마운트 nginx 로컬파일 site/index.html 이 컨테이너에서 보이지 않음`
```bash
% docker run -d -p 8080:80 --name my-mount-nginx -v ~/site:/usr/share/nginx/html nginx:alpine
```
증상:
호스트의 파일이 컨테이너에서 보이지 않음
디렉토리는 마운트되었지만 파일이 없음
권한 오류는 없음

- 원인 가설: `호스트 경로가 존재하지 않음`
- 확인 방법: `호스트 경로 확인`
```bash
$ ls -la ~/site
```
증상:
파일이 없음
계정 ~/site 경로로 연결해 놓고 
/proejct/cds-w1-m1/site/index.html 에 연결된 걸로 착각

- 해결/대안: `~/site/index.html 파일생성`
```bash
% cd ~
% cd mkdir site
% cp project/cds-w1-m1/site/index.html site/index.html
% cat ~/site/index.html
```

---

### 이슈 2
- 문제: `{{문제 설명}}`
- 원인 가설: `{{원인 추정}}`
- 확인 방법: `{{확인 명령}}`
- 해결/대안: `{{해결 방법}}`

```bash
{{관련 로그}}
```

---

## 15. 결과 정리

이번 미션을 통해 다음을 이해했다.

- 절대 경로와 상대 경로의 차이
- 파일 권한(r/w/x)과 `755`, `644`의 의미
- Dockerfile 기반 커스텀 이미지 제작 방법
- 포트 매핑이 필요한 이유
- Docker 볼륨의 영속성 개념
- Git과 GitHub의 역할 차이

---

## 16. 첨부 자료

- Dockerfile: `{{경로}}`
- 웹 서버 소스코드: `{{경로}}`
- 포트 매핑 접속 스크린샷: `{{경로}}`
- 바인드 마운트 증거: `{{경로}}`
- 볼륨 영속성 증거: `{{경로}}`
- Git/GitHub 연동 증거: `{{경로}}`