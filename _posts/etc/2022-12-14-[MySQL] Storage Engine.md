---
layout: single
title: "[MySQL] Storage Engine"
categories: etc
tag: [etc, sql]
toc: true
toc_sticky: true
author_profile: false
---
## [MySQL] Storage Engine

* Mysql Storage Engine은 물리적 저장장치에서 데이터를 어떤 식으로 구성하고 읽어올지를 결정하는 역할을 한다.

* 8가지의 스토리지 엔진이 탑재되어 있으며 CREATE TABLE문을 사용하여 테이블을 생성할 때 엔진 이름을 추가함으로써 간단하게 설정할 수 있다.

* 대표적인 스토리지 엔진으로 InnoDB, MyISAM, Archive가 있다.

  

## InnoDB

* default로 설정되는 스토리지 엔진
* 트랜잭션을 지원하고, 커밋과 롤백 그리고 데이터 복구 기능을 제공하므로 데이터를 효과적으로 보호할 수 있다.
* row-level locking을 제공, 테이블에 CRUD할 때 row 단위로 lock을 하여 multi-thread에 효율적
* 데이터를 clustered index에 PK기준으로 정렬되도록 저장하여, PK기반의 query의 비용을 줄인다.
* PK 제약을 제공하여 데이터 무결성을 보장



## MyISAM

* 트랜잭션을 지원하지 않고 table-level locking을 제공
* 테이블 전체에 락을 잡기 때문에 multi-thread 환경에서 성능이 저하될 수 있다
* InnoDB에 비해 기능적으로 단순하므로 대부분의 작업은 InnoDB보다 속도면에서 우월
* Order By등 정렬 기능이 들어간다면 clustered index를 사용하는 InnoDB보다 느리다.



## Archive

* 로그 수집에 적합한 엔진
* 데이터가 메모리상에서 압축되고 압축된 상태로 디스크에 저장되기 때문에 row-level locking이 가능
* INSERT된 데이터는 UPDATE, DELETE를 사용할 수 없으며 인덱스를 지원하지 않는다.
* 가공하지 않을 원시 로그 데이터를 관리하는데에 효율적일 수 있고, 테이블 파티셔닝도 지원



## 정리

* Mysql Storage Engine은 물리적 저장장치에서 데이터를 어떤 식으로 구성하고 읽어올지를 결정하는 역할을 하며, 여러 종류의 Storage Engine이 있다.



## 참고

* <a href="https://jobc.tistory.com/196" target="_blank">[MySQL] Storage Engine (InnoDB vs MyISAM)</a>



## 보완/복습

* 2023.10.06 내용 보완 완료

