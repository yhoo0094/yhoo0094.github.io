---
layout: single
title: "HTTP-Only Cookie"
categories: etc
tag: [etc]
toc: true
toc_sticky: true
author_profile: false
---
## HTTP-Only Cookie

* Set-Cookie 헤더로 서버에서 쿠키를 설정할 때 **HttpOnly** 옵션을 붙이면 **브라우저의 JavaScript에서는 해당 쿠키에 접근 불가**

* JavaScript로 쿠키를 읽을 수 없으므로 XSS(크로스 사이트 스크립팅) 방어에 유리

| 구분            | 일반 쿠키                | HTTP-Only 쿠키                      |
| --------------- | ------------------------ | ----------------------------------- |
| JavaScript 접근 | 가능 (`document.cookie`) | ❌ 불가능                            |
| XSS 위험        | 있음                     | 낮음                                |
| 사용 용도       | UI 기능, 추적 등         | **Refresh Token 저장 등 민감 정보** |



## 참고

* ChatGPT-4.0



## 보완/복습

* 2025.07.01 생성

