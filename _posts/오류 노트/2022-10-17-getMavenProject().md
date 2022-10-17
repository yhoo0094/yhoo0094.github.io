---
layout: single
title: "getMavenProject() 오류"
categories: error
tag: [error, spring]
toc: true
toc_sticky: true
author_profile: false
---
## 상황

* git을 이용해 이클립스에 프로젝트 import했는데 아래와 같은 오류 발생, maven update 시도하면 계속 같은 오류가 발생 
* java.lang.NoSuchMethodError: 'org.apache.maven.project.MavenProject org.eclipse.m2e.core.project.configurator.ProjectConfigurationRequest.getMavenProject()'



## 원인

* 기존 IDE에는 STS4가 설치되어 있었으나 import한 IDE에 STS4가 설치되어 있지 않았다



## 해결

* [Help] - [Eclipse Marketplace] - STS검색 - Spring Tools 4 설치

