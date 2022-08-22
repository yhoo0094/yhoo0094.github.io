---
layout: single
title: "[Java] URLConnection & HttpURLConnection"
categories: etc
tag: [etc, JAVA]
toc: true
toc_sticky: true
author_profile: false
---
## java.net.URLConnection

* 사용자 인증이나 보안이 설정되어 있지 않은 웹서버에 접속하여 파일 등을 다운로드하는데 많이 사용
* URLConnection은 리소스에 연결하기 전에 구성 되어야 한다
* URLConnection 인스턴스는 재사용 될 수 없다



## java.net.HttpURLConnection

* URLConnection을 구현한 클래스
* 생성자가 protected로 선언되어 openConnection() 메서드로 객체 생성

```java
URL u = new URL("http://www.naver.com");

HttpURLConnection http = (HttpURLConnection) u.openConnection();
```

* 기본적으로 GET 요청방식 사용, setRequestMethod() 메서드를 사용해서 변경 가능



## 참고

* <a href="https://goddaehee.tistory.com/161" target="_blank">[Java] URLConnection & HttpURLConnection</a>

