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
uname -a
echo $SHELL
docker --version
docker info
git --version
git config --list
```

### 결과
```bash
% uname -a
Darwin /RELEASE_X86_64 x86_64
% git --version
git version 2.53.0
% docker --version
Docker version 28.5.2, build ecc6942
% echo $SHELL
/bin/zsh
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
touch empty.txt
cat {{파일명}}
```

### 결과
```bash
{{출력}}
```

---

## 5. 권한 실습

### 5-1. 파일 권한 확인 및 변경
대상 파일: `{{파일명}}`

```bash
ls -l {{파일명}}
chmod 644 {{파일명}}
ls -l {{파일명}}
chmod 755 {{파일명}}
ls -l {{파일명}}
```

### 변경 전/후
```bash
{{출력}}
```

### 5-2. 디렉토리 권한 확인 및 변경
대상 디렉토리: `{{디렉토리명}}`

```bash
ls -ld {{디렉토리명}}
chmod 755 {{디렉토리명}}
ls -ld {{디렉토리명}}
```

### 변경 전/후
```bash
{{출력}}
```

---

## 6. Docker 설치 및 기본 점검

### 6-1. 버전 확인
```bash
docker --version
docker info
```

### 결과
```bash
{{출력}}
```

### 6-2. 이미지 / 컨테이너 상태 확인
```bash
docker images
docker ps
docker ps -a
```

### 결과
```bash
{{출력}}
```

---

## 7. 컨테이너 실행 실습

### 7-1. hello-world 실행
```bash
docker run --rm hello-world
```

### 결과
```bash
{{출력}}
```

### 7-2. ubuntu 컨테이너 실행 및 내부 명령 실행
```bash
docker run -it --name ubuntu-test ubuntu bash
ls
echo "hello docker"
exit
```

### 결과
```bash
{{출력}}
```

### 7-3. attach / exec / 종료 차이 메모
- `attach`: 실행 중인 컨테이너의 표준 입출력에 연결
- `exec`: 실행 중인 컨테이너 안에서 새 명령 실행
- 종료 후 컨테이너 상태: `{{정리 내용}}`

---

## 8. Dockerfile 기반 커스텀 이미지

### 8-1. 선택한 베이스 이미지
- 베이스 이미지: `{{예: nginx:alpine / ubuntu:22.04}}`

### 8-2. 커스텀 포인트
- `{{예: HTML 정적 파일 교체}}`
- `{{예: 설정 파일 변경}}`
- `{{예: 환경변수 추가}}`
- `{{예: 헬스체크 추가}}`

### 8-3. 프로젝트 구조
```bash
{{예시}}
project/
├── Dockerfile
├── app/
│   └── index.html
└── README.md
```

### 8-4. Dockerfile
```dockerfile
{{Dockerfile 내용}}
```

### 8-5. 빌드 명령
```bash
docker build -t {{이미지이름}} .
```

### 결과
```bash
{{출력}}
```

### 8-6. 실행 명령
```bash
docker run -d --name {{컨테이너이름}} -p {{host_port}}:{{container_port}} {{이미지이름}}
```

### 결과
```bash
{{출력}}
```

---

## 9. 포트 매핑 접속 증거

### 접속 확인 명령
```bash
curl http://localhost:{{host_port}}
```

### 결과
```bash
{{출력}}
```

### 브라우저 접속 증거
- 접속 주소: `http://localhost:{{host_port}}`
- 스크린샷 링크: `{{이미지 링크 또는 파일 경로}}`

---

## 10. 바인드 마운트 검증

### 10-1. 실행 명령
```bash
docker run -d --name {{컨테이너이름}} \
  -p {{host_port}}:{{container_port}} \
  -v {{호스트경로}}:{{컨테이너경로}} \
  {{이미지이름}}
```

### 10-2. 변경 전/후 비교
호스트 파일 수정 전:
```bash
{{내용}}
```

호스트 파일 수정 후:
```bash
{{내용}}
```

컨테이너 반영 확인:
```bash
{{명령}}
```

### 결과
```bash
{{출력}}
```

---

## 11. Docker 볼륨 영속성 검증

### 11-1. 볼륨 생성
```bash
docker volume create {{볼륨이름}}
docker volume ls
```

### 결과
```bash
{{출력}}
```

### 11-2. 볼륨 연결 컨테이너 실행
```bash
docker run -d --name {{컨테이너이름}} \
  -v {{볼륨이름}}:{{컨테이너경로}} \
  ubuntu sleep infinity
```

### 11-3. 데이터 저장 및 확인
```bash
docker exec -it {{컨테이너이름}} bash -lc 'echo "hello" > {{컨테이너경로}}/test.txt && cat {{컨테이너경로}}/test.txt'
```

### 결과
```bash
hello
```

### 11-4. 컨테이너 삭제 후 재실행
```bash
docker rm -f {{컨테이너이름}}
docker run -d --name {{새컨테이너이름}} \
  -v {{볼륨이름}}:{{컨테이너경로}} \
  ubuntu sleep infinity

docker exec -it {{새컨테이너이름}} bash -lc 'cat {{컨테이너경로}}/test.txt'
```

### 결과
```bash
hello
```

---

## 12. Git 설정 및 GitHub 연동

### 12-1. Git 기본 설정
```bash
git config --global user.name "{{이름}}"
git config --global user.email "{{이메일}}"
git config --global init.defaultBranch main
git config --list
```

### 결과
```bash
{{출력}}
```

### 12-2. 저장소 연동
- GitHub Repository: `{{저장소 링크}}`
- 원격 저장소 등록:
```bash
git remote add origin {{저장소주소}}
git remote -v
```

### 결과
```bash
{{출력}}
```

### 12-3. VSCode 연동 증거
- GitHub 로그인 완료: `{{예/아니오}}`
- VSCode Source Control 연동 확인: `{{예/아니오}}`
- 스크린샷 링크: `{{이미지 링크 또는 파일 경로}}`

---

## 13. 검증 방법 요약

아래 명령으로 결과를 확인했다.

- 디렉토리/파일 조작: `pwd`, `ls -la`, `mkdir`, `cp`, `mv`, `rm`
- 권한 확인: `ls -l`, `chmod`
- Docker 점검: `docker --version`, `docker info`
- 컨테이너 실행: `docker run`, `docker ps`, `docker ps -a`
- 로그 확인: `docker logs`, `docker stats`
- 이미지 빌드: `docker build`
- 접속 확인: `curl http://localhost:PORT`
- 볼륨 확인: `docker volume ls`, `docker exec`
- Git 설정: `git config --list`

---

## 14. 트러블슈팅

### 이슈 1
- 문제: `{{문제 설명}}`
- 원인 가설: `{{원인 추정}}`
- 확인 방법: `{{확인 명령}}`
- 해결/대안: `{{해결 방법}}`

```bash
{{관련 로그}}
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

## 15. 보안 및 개인정보 보호

- 토큰, 비밀번호, 개인키, 인증 코드는 README와 캡처에 포함하지 않았다.
- 필요한 경우 민감정보는 `***`로 마스킹했다.
- 공개 저장소에 올리기 전에 로그와 스크린샷을 재확인했다.

---

## 16. 결과 정리

이번 미션을 통해 다음을 이해했다.

- 절대 경로와 상대 경로의 차이
- 파일 권한(r/w/x)과 `755`, `644`의 의미
- Dockerfile 기반 커스텀 이미지 제작 방법
- 포트 매핑이 필요한 이유
- Docker 볼륨의 영속성 개념
- Git과 GitHub의 역할 차이

---

## 17. 첨부 자료

- Dockerfile: `{{경로}}`
- 웹 서버 소스코드: `{{경로}}`
- 포트 매핑 접속 스크린샷: `{{경로}}`
- 바인드 마운트 증거: `{{경로}}`
- 볼륨 영속성 증거: `{{경로}}`
- Git/GitHub 연동 증거: `{{경로}}`