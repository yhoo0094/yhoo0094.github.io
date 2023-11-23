---
layout: single
title: "Web Server와 WAS(Web Application Server)"
categories: etc
tag: [etc, interview]
toc: true
toc_sticky: true
author_profile: false
---
## Web Server (웹 서버)

* 클라이언트로부터 HTTP 요청을 받고, 정적인 웹 페이지, 이미지, CSS, JavaScript 파일 등과 같은 정적 리소스 제공
* 동적 콘텐츠를 처리하는 WAS로 요청 전달
* 대표적인 웹 서버로는 Apache, Nginx, Microsoft IIS 등이 있다



## Web Application Server (WAS, 웹 애플리케이션 서버)

* 동적인 웹 애플리케이션을 실행하기 위한 소프트웨어
* 데이터베이스와 상호 작용하며, 사용자 요청에 따라 동적 콘텐츠를 생성
* HTTP 요청을 받아서 비즈니스 로직을 처리하고 데이터베이스와 통신하여 동적 콘텐츠를 생성한 후, 그 결과를 클라이언트에게 반환
* Java EE (Enterprise Edition) 애플리케이션을 위한 WAS로는 Apache Tomcat, IBM WebSphere, Oracle WebLogic 등이 있다



## 웹 서버와 WAS의 협업

1. 클라이언트로부터의 요청이 웹 서버로 들어옵니다.
2. 웹 서버는 정적 리소스 요청의 경우 해당 리소스를 바로 반환하고, 동적 콘텐츠 요청의 경우 해당 요청을 WAS에 전달합니다.
3. WAS는 동적 콘텐츠를 생성하기 위해 비즈니스 로직을 실행하고 데이터베이스와 상호 작용합니다.
4. 생성된 동적 콘텐츠를 WAS가 웹 서버로 반환하고, 웹 서버는 이를 클라이언트에게 전달합니다.



## 정리

Q) 웹 서버와 WAS가 무엇인가요?

* 웹 서버는 정적인 리소스를 처리하고, WAS는 동적인 콘텐츠를 처리합니다.

* 웹 서버는 클라이언트로부터 HTTP 요청을 받아 이미지, CSS, JS와 같은 정적인 리소스를 반환합니다. 만약 동적 콘텐츠 요청인 경우 해당 요청을 WAS에 전달합니다. WAS는 동적 콘텐츠를 생성하기 위해 비즈니스 로직을 실행하고 데이터베이스와 상호 작용하여 결과를 웹 서버에 반환합니다. 웹 서버는 이 결과를 클라이언트에게 전달합니다.



## 참고

ChatGPT-4.0



## 보완/복습

* 2023.10.30 생성
