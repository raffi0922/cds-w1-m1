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
