---
layout: single
title: "BCryptPasswordEncoder"
categories: etc
tag: [etc, spring]
toc: true
toc_sticky: true
author_profile: false
---
## BCryptPasswordEncoder

* Spring Security에서 제공하는 **비밀번호 암호화(해시화)**를 위한 클래스

* 주요특징

| 항목               | 설명                                                         |
| ------------------ | ------------------------------------------------------------ |
| **알고리즘**       | BCrypt (Blowfish 기반 해시 함수)                             |
| **보안성**         | 느린 계산 속도로 brute-force 공격에 강함                     |
| **Salt 자동 포함** | 내부적으로 자동으로 고유한 salt를 생성함                     |
| **강도 설정**      | work factor (`strength`)를 통해 반복 횟수 설정 가능 (기본 10) |

* encode 결과

```
$2a$10$uRQbM1zjHaS3u7QkVKpye.1nUv8z1CseNOkOVS6Tb/OzXm6n0aCh2
 └┬┘ └┬┘ └────────────────────────────┬──────────────────────────────┘
  │   │                               │
버전  cost                      salt + 해시 결과
```

| 구간                     | 예시   | 설명                                                  |
| ------------------------ | ------ | ----------------------------------------------------- |
| `$2a$`                   | `$2a$` | 알고리즘 버전 (2a, 2b 등)                             |
| `10$`                    | `10`   | cost factor (2^10 = 1024회 반복)                      |
| `uRQbM1zjHaS3u7QkVKpye.` | 22자   | **Base64로 인코딩된 16바이트 salt**                   |
| 나머지                   | 나머지 | 실제 해시 결과 (salt와 비밀번호로 만든 24바이트 해시) |



## 보안성

* 느린 계산 속도로 brute-force 공격에 강함
* **brute-force 공격**: 공격자가 가능한 모든 비밀번호 조합을 시도하여 원래 비밀번호를 찾는 방식

* **빠른 해시 함수 (SHA-256 등)** → 암호화/파일검증용으로는 적합하지만 비밀번호 보관에는 위험
* **느린 해시 함수 (BCrypt, Argon2, PBKDF2 등)** → brute-force에 강함 → 비밀번호 보관에 적합



## 참고

* ChatGPT-4.0



## 보완/복습

* 2025.06.23 생성

