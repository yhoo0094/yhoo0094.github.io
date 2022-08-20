---
layout: single
title: "라이브러리 설정_ClassNotFoundException"
categories: error
tag: [error, spring]
toc: true
toc_sticky: true
author_profile: false
---
## 상황

* 티베로 DB 연결을 위해 tibero4-jdbc.jar 파일을 라이브러리에 추가하고자 함
* project 오른쪽 클릭 - [Properties] - [Java Build Path] - [Libraries] - [Add External JARs] - jar 파일 선택
* 서버에서 프로젝트 실행 후 DB 접속 시도하면 ClassNotFoundException 발생

-> com.tmax.tibero.jdbc.TbDriver 클래스를 못 찾음

<img src="../../images/2022-08-19-라이브러리 설정_ClassNotFoundException/image-20220819093546583.png" alt="image-20220819093546583" style="zoom:80%;" />

 



## 원인

* Java Build Path 동작 관련 문제로 파악되나 세부적인 원인은 파악하지 못함



## 해결

* 방법1: 스프링인 경우 프로젝트의 WEB-INF\lib\ 하위에 tibero4-jdbc.jar 파일 추가
* 방법2: project 오른쪽 클릭 - [Run As] - [Run Configurations] - [Apache Tomcat] 하위의 서버 선택 -

[Classpath] - [Add External JARs] - jar 파일 선택

 <img src="../../images/2022-08-19-라이브러리 설정_ClassNotFoundException/image-20220819094405120.png" alt="image-20220819094405120" style="zoom:80%;" />



