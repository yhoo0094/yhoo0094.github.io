---
layout: single
title: "properties 파일 읽기"
categories: spring framework
tag: [spring framework]
toc: true
toc_sticky: true
author_profile: false
---

##  properties 파일 읽기

1.  globals.properties 구현(CLASSPATH 경로 아래에 위치하도록)

```
#OS타입
Global.OsType = WINDOWS

#서버타입
Global.OnServerType = LOCAL

#LOCAL 파일 저장 경로
Global.LOCAL.getComFilePath = C:/data/hppnas/
```



2. Configuration 클래스 구현

```java
package com.ksm.hpp.framework.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.Properties;

import com.ksm.hpp.framework.exception.ConfigurationException;

public class Configuration {

	private String configFileName; //설정 파일 이름
	protected Properties props = null;	//모든 속성값

	public Configuration() throws ConfigurationException {
		// java.net.URL dbURL = ClassLoader.getSystemResource("config/globals.properties"); //계속 null 반환해서 아래 사용
		ClassLoader currentThreadClassLoader = Thread.currentThread().getContextClassLoader();
        //"config/globals.properties"는 CLASSPATH 하위의 properties 파일 경로
		java.net.URL dbURL = currentThreadClassLoader.getResource("config/globals.properties");	
		
		if (dbURL == null) {
			File defaultFile = new File(System.getProperty("user.home"), "config/globals.properties");
			configFileName = System.getProperty("javacan.config.file", defaultFile.getAbsolutePath());
		} else {
			File fileName = new File(dbURL.getFile());
			configFileName = fileName.getAbsolutePath();
		}

		try {
			File configFile = new File(configFileName);
			if (!configFile.canRead()) {
				throw new ConfigurationException(configFileName + "파일을 열 수 없습니다.");
			}

			props = new Properties();
			FileInputStream fin = new FileInputStream(configFile);
			props.load(new BufferedInputStream(fin));
			fin.close();
		} catch (Exception ex) {
			throw new ConfigurationException(configFileName + "파일을 열 수 없습니다.");
		}
	}
	
	//모든 속성 이름을 구한다.
	public Properties getProperties() {
		return props;
	}

	//String 타입 속성값을 읽어온다.
	public String getString(String key) {
		String value = props.getProperty(key);
		if (value == null) {
			throw new IllegalArgumentException("Illegal String key : " + key);
		}
		return value;
	}

	//int 타입 속성값을 읽어온다.
	public int getInt(String key) {
		int value = 0;
		try {
			value = Integer.parseInt(props.getProperty(key));
		} catch (Exception ex) {
			throw new IllegalArgumentException("Illegal int key : " + key);
		}
		return value;
	}

	//double 타입 속성값을 읽어온다.
	public double getDouble(String key) {
		double value = 0.0;
		try {
			value = Double.valueOf(props.getProperty(key)).doubleValue();
		} catch (Exception ex) {
			throw new IllegalArgumentException("Illegal double key : " + key);
		}
		return value;
	}

	//boolean 타입 속성값을 읽어온다.
	public boolean getBoolean(String key) {
		boolean value = false;
		try {
			value = Boolean.valueOf(props.getProperty(key)).booleanValue();
		} catch (Exception ex) {
			throw new IllegalArgumentException("Illegal boolean key : " + key);
		}
		return value;
	}	
}
```

```java
package com.ksm.hpp.framework.exception;

public class ConfigurationException extends Exception {
	public ConfigurationException() {
		super();
	}

	public ConfigurationException(String s) {
		super(s);
	}
}
```

3. properties 내용 불러오기

```java
Configuration conf = new Configuration();
String filePath = conf.getString("Global.LOCAL.getComFilePath");
```



## 참고

<a href="https://javacan.tistory.com/entry/4" target="_blank">java.util.Properties 클래스를 이용한 어플리케이션의 프로퍼티 설정</a>

<a href="https://hamait.tistory.com/360" target="_blank">자바 경로 (Path) 및 사용법 정리</a>



