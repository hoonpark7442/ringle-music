# README

지원동기 부족하다고 탈락함....그래..중요하지 지원동기...

## Initial Setup

```
bundle install
rails db:create
rails db:migrate
```

## Configuration
### JWT 세팅
1. 아래 명령어로 루트디렉토리에 .env 파일을 만들어 주세요
```
touch .env
```
2. 아래 명령어로 secret 코드를 만들어 주세요
```
rake secret
```
3. .env 파일에 아래와 같이 작성해주세요
```
DEVISE_JWT_SECRET_KEY=<your_rake_secret>
```

## Database
db seed 명령어로 테스트를 위한 데이터를 삽입해주세요
```
rails db:seed
```

## Login
1. 테스트 전 test user에 로그인 하여 jwt 토큰을 얻어야만 합니다
```
curl -XPOST -i -H "Content-Type: application/json" -d '{ "user": { "email": "test@test.com", "password": "123123" } }' http://localhost:3000/users/sign_in
```

2. response에서 Authorization 부분의 jwt 토큰을 이용하여 그룹 생성, 개인 플레이리스트 생성, 개인 플레이리스트에 곡 추가/삭제, 그룹 플레이리스트 생성, 그룹 플레이리스트에 곡 추가/삭제 가 가능합니다

## Test
아래 API 문서를 확인해주세요
https://documenter.getpostman.com/view/14873272/UzBqnQ9d

그룹 관련 작업은 가입되어있는 그룹 확인이 필요합니다. 아래 url로 가입되어있는 그룹을 확인해주세요
```
GET http://localhost:3000/api/v1/groups
```
