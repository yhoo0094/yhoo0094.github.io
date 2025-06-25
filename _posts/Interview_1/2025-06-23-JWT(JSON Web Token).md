---
layout: single
title: "JWT(JSON Web Token)"
categories: etc
tag: [etc, spring]
toc: true
toc_sticky: true
author_profile: false
---
## JWT(JSON Web Token)

- JSON 기반의 토큰 인증 방식
- 클라이언트와 서버 간 신원 정보 또는 인증 정보를 안전하게 전달하기 위해 사용하는 토큰 포맷
- 주로 로그인 후 인증 정보를 담아 프론트와 백엔드 사이에서 주고받을 때 사용



## JWT 구성

* JWT는 `.`(dot)으로 구분된 3개의 파트로 구성
  * Header: 토큰의 타입(JWT)과 서명 알고리즘(예: HS256, RS512 등) 명시
  * Payload: 사용자 정보와 같은 클레임(Claims, key-value 형태의 데이터) 포함
  * Signature: 위 두 개를 비밀 키로 서명한 값으로, 무결성 보장 목적
* 예시

```
Header:
{
  "alg": "HS256",
  "typ": "JWT"
}

Payload:
{
  "sub": "user123",
  "name": "홍길동",
  "exp": 1710000000
}

Signature:
HMACSHA256(base64UrlEncode(header) + "." + base64UrlEncode(payload), secret)
```



## 특징

* 장점
  * 서버가 세션 상태를 저장하지 않아도 됨 (Stateless)
  * 토큰 기반으로 인증 방식이 간단함
  * 다양한 플랫폼에서 사용 가능
* 단점
  * Payload가 인코딩되어 있지만 암호화되어 있진 않음 (정보 노출 주의)
  * 발급 후 만료 전까지 강제 무효화가 어려움 (ex. 탈퇴, 로그아웃 등)
  * 서명 키 유출 시 보안에 큰 문제 발생



## 사용

* 로그인 인증 및 권한 확인

* OAuth 2.0의 Access Token

* 마이크로서비스 간 사용자 정보 전달



## 참고

* ChatGPT-4.0



## 보완/복습

* 2025.06.23 생성

