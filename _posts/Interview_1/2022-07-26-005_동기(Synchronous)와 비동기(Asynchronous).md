---
layout: single
title: "동기(Synchronous)와 비동기(Asynchronous)"
categories: etc
tag: [etc, interview]
toc: true
toc_sticky: true
author_profile: false
---
## 동기(Synchronous)

* 요청에 대해 순차적으로 처리하는  것
* 장점: 설계가 직관적이고 간단하다
* 단점: 요청이 완료될 때까지 다른 작업을 수행할 수 없다

ex) 사용자가 데이터를 서버에 요청한다면 서버가  응답을 주기 전까지 사용자는 다른 활동을 할 수 없으며 기다려야만 한다.



## 비동기(Asynchronous)

* 요청에 대해 비순차적으로 처리하는  것
* 장점: 동시에 여러가지 일을 처리할 수 있다
* 단점: 설계가 복잡하다
* 콜백(callbacks), 프로미스(promises), async/await 등으로 구현



## 정리

* 동기는 요청에 대해 순차적으로 처리하는 것으로 구현이 쉽지만, 한 작업이 완료될 때까지 다른 작업이 기다려야 하므로 효율성이 떨어질 수 있다. 비동기는 요청에 대해 비순차적으로 처리하는 것으로 구현이 상대적으로 복잡하지만 여러 작업을 동시에 처리하여 효율적이다.



## 참고

<a href="https://velog.io/@slobber/%EB%8F%99%EA%B8%B0%EC%99%80-%EB%B9%84%EB%8F%99%EA%B8%B0%EC%9D%98-%EC%B0%A8%EC%9D%B4" target="_blank">동기와 비동기의 차이</a>

ChatGPT-4.0



## 보완/복습

* 2023.10.30 보완
* 2023.11.07 복습
