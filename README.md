# TODOList
썸머코딩 과제용 레퍼지토리

# 작업 환경
window, linux 터미널
STS 환경에서 작업하였습니다

# 필요한 설치 파일
자바 1.8
web-app runner
tomcat 8.5 vesion
heroku cli

# 테스트 케이스 실행을 위한 파일
Juint 4.12 version
hamcrest

# 기타
pom.xml에 dependency로 정의 되어있음

# 빌드, 설치 순서
1. pom.xml 경로로 이동 (pom.xml에 web-app runner 추가)
2. mvn package
3. local에서 테스트 하기 위한 구동 java -jar target/dependency/webapp-runner.jar target/todolist.war 
4. port 8080으로 테스트 가능
5. heroku 배포를 위한 과정 => procfile 파일 설정(확장자 없음) 
=> web: java $JAVA_OPTS -jar target/dependency/webapp-runner.jar --port $PORT target/*.war
6. git init => git add . => git commit => heroku create
7. git push heroku master
8. heroku addons:create jawsdb-maria
9. heroku config:get JAWSDB_MARIA_URL <= URL, username, password, database 확인
10. TABLE 생성
11. heroku open
