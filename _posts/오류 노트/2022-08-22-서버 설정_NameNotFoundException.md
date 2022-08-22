---
layout: single
title: "서버 설정_NameNotFoundException"
categories: error
tag: [error, spring]
toc: true
toc_sticky: true
author_profile: false
---
## 상황

* 서버 실행 시 javax.naming.NameNotFoundException 발생 jdbc/myTebero를 못 찾는다고 함



## 원인

* 



## 해결

* servers/tomcat/context.xml 에 <ResourceLink name="jdbc/myTebero" ... type="javax.sql.DataSource /> 추가해서 해결



