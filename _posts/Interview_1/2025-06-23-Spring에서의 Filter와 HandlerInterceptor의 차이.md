---
layout: single
title: " Spring에서 Filter와 HandlerInterceptor의 차이"
categories: etc
tag: [etc, spring]
toc: true
toc_sticky: true
author_profile: false
---
## Spring에서 Filter와 HandlerInterceptor의 차이

- 요청 처리 흐름 도식

```
클라이언트 요청
     ↓
[Filter] 🔐 (서블릿 필터, 예: 인증/보안/JWT)
     ↓
[DispatcherServlet]
     ↓
[HandlerInterceptor] 🛠 (스프링 인터셉터, 예: 로깅/권한 확인)
     ↓
[Controller] (요청 처리)
     ↓
[HandlerInterceptor - postHandle()] 🛠
     ↓
[DispatcherServlet]
     ↓
[Filter - 응답 처리] 🔐
     ↓
클라이언트 응답
```



- 주요 차이점 요약

| 항목                     | `Filter`                                          | `HandlerInterceptor`                              |
| ------------------------ | ------------------------------------------------- | ------------------------------------------------- |
| 위치                     | **DispatcherServlet 이전**                        | **DispatcherServlet 이후**                        |
| 인터페이스               | `javax.servlet.Filter` / `jakarta.servlet.Filter` | `HandlerInterceptor`                              |
| 사용 목적                | **보안, 인증, 로깅 등 서블릿 단 레벨 제어**       | **로깅, 권한 체크, 공통 파라미터 설정 등**        |
| 사용 범위                | 서블릿 전체                                       | Spring MVC에서 매핑된 요청만                      |
| 요청/응답 모두 처리 가능 | O                                                 | O (preHandle / postHandle / afterCompletion)      |
| Spring Context 접근      | 제한적                                            | 완전 가능 (빈 주입, 서비스 호출 등 자유롭게 가능) |
| JWT 인증 필터 적합 여부  | ✅ 매우 적합 (`OncePerRequestFilter`)              | ❌ 부적합                                          |



## 참고

* ChatGPT-4.0



## 보완/복습

* 2025.06.23 생성

