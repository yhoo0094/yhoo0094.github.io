---
layout: single
title: "OncePerRequestFilter 와 HandlerInterceptor"
categories: etc
tag: [etc, spring]
toc: true
toc_sticky: true
author_profile: false
---
## OncePerRequestFilter 와 HandlerInterceptor

| 항목                       | OncePerRequestFilter                                      | HandlerInterceptor                             |
| -------------------------- | --------------------------------------------------------- | ---------------------------------------------- |
| **적용 시점**              | 필터 체인 시작 시점 (Spring Security 포함 전 영역에 적용) | DispatcherServlet 이후                         |
| **보안 관련 요청 처리**    | 🔒 가능 (예: 인증/인가, 헤더/쿠키 검사)                    | ❌ 한계 있음                                    |
| **입출력 스트림 접근**     | 가능 (요청/응답 직접 수정 가능)                           | 제한적                                         |
| **JWT 갱신과 쿠키 재설정** | ✅ 완벽히 가능                                             | 일부 한계 있음 (응답 커밋 이후 쿠키 수정 불가) |
| **중복 호출 방지**         | 기본적으로 1요청 1실행 보장                               | 컨트롤러 단위로 작동할 수 있음                 |



* **HandlerInterceptor**

  * 로그인 여부나 역할(Role) 검증, URI 권한 확인 등 **비즈니스 단의 인가 로직**을 분리할 때 유용
  * 역할 인가, 메뉴 접근 제어

* **OncePerRequestFilter**

  * 쿠키 수정이나 보안 토큰 갱신처럼 **HTTP 레벨 조작이 필요한 경우에는 필터가 더 안정적**
  * 토큰 갱신

  

## 참고

* ChatGPT-4.0



## 보완/복습

* 2025.07.01 생성

