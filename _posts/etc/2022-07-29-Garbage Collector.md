---
layout: single
title: "Garbage Collector"
categories: etc
tag: [etc, interview]
toc: true
toc_sticky: true
author_profile: false
---
## Garbage Collection

* Heap 영역의 메모리에서 사용하지 않는 인스턴스를 자동으로 삭제하는 행위
*  JVM의 Garbage Collector가 수행



## Stop The World

* Garbage Collection 이외의 모든 Thread의 작업이 멈추는 상태
* GC(Garbage Collection) 튜닝을 통해 Stop The World 시간을 최소화한다



## Sun JVM의 Generation Heap

* 일반적은 자바 어플리케이션의 경우 오래 사용되는 객체에 비해, 짧게 사용 후 필요 없어지는 객체가 많다
* Young Generation

\- 생명 주기가 짧은 객체 대상 영역

\- 두 개의 Survivor space가 존재

\- 해당 영역에서 발생되는 GC를 Minor GC 라고 하며 속도가 빠르다

* Old Generation

\- 생명 주기가 긴 대상 영역

\- 해당 영역에서 발생되는 GC를 Major GC 라고 하며 속도가 느리다

* Sun JVM의 Heap 영역 메모리 동작 과정

1. Young Generations의 Eden에 객체 생성
2. Eden이 Full이 되면 GC 발생, 살아남은 객체는 Survivor 영역 중 From Space로 이동

=> Eden에서 사용되고 있지 않거나 참조하고 있지 않는 객체는 삭제하고 나머지는 From Space로 이동

3. 다음 GC가 발생하면 From Space의 객체는 To Space로 이동

4. 다음 GC가 발생 시 객체가 여전히 살아있는 상태라면 Old Generationd 영역으로 이동

<img src="../../images/2022-07-29-Garbage Collector/image-20220729094616336.png" alt="image-20220729094616336" style="zoom: 80%;" />



## 마크 앤 스윕(Mark and Sweep)

* Garbage Collector의 메모리 정리 방법
* **GC Root**: 힙 외부에서 접근할 수 있는 변수나 오브젝트 => 가비지 컬렉션의 Root

1. 실행중인 쓰레드 (Active Thread)
2. 정적 변수 (Static Variable)
3. 로컬 변수 (Local Variable)
4. JNI 레퍼런스 (JNI Reference)

* **Mark**: GC Root가 참조하는 오브젝트와 그 오브젝트가 참조하는 다른 오브젝트들을 탐색해 내려가며 마크(Mark)한다
* **Sweep**: Mark가 끝나면 가비지 컬렉터는 힙 내부의 Mark되지 않은 메모리들을 해제한다



## 정리

* Garbage Collector란?

\- **Heap 영역의 메모리에서 사용하지 않는 인스턴스를 자동으로 삭제하는 JVM의 기능입니다.** Garbage Collector를 사용할 땐 모든 Thread가 멈추기 때문에 튜닝을 통해 멈추는 시간을 최소화할 필요가 있습니다.

* Garbage Collector의 Young Generation과 Old Generation은 무엇인가?

\- 일반적은 자바 어플리케이션의 경우 짧게 사용 후 필요 없어지는 객체가 많습니다. **Young Generation에서는 Minor Garbage Collection을 통해 사용되고 있지 않거나 참조하고 있지 않는 객체를 빠르게 제거합니다. 제거 후 살아남은 객체는 일련의 과정을 거쳐 Old Generation으로 이동되며 Old Generation에서 발생하는 Major Garbage Collection은 Minor Garbage Collection에 비해 속도가 느립니다.**



## 참고

<a href="https://www.holaxprogramming.com/2013/07/20/java-jvm-gc/" target="_blank">JVM의 Garbage Collection</a>

<a href="https://imasoftwareengineer.tistory.com/103" target="_blank">가비지 컬렉터(Garbage Collector)와 Mark & Sweep</a>

