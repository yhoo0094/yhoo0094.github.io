---
layout: single
title: "Iterator(JAVA)"
categories: etc
tag: [etc, JAVA]
toc: true
toc_sticky: true
author_profile: false
---
## Iterator(JAVA)

*  Collection에서 데이터들을 중복없이 하나 씩 꺼낼 수 있게 해준다
* 자바에서 Iterator 인터페이스를 제공, List나 Map, Set 등이 Iterator 를 구현
* for문에서는 요소의 개수 파악 후 반복문을 수행하는데 Iterator는 개수를 파악하지 않고 모든 요소를 순차적으로 불러온다
* Iterator 인스턴스는 `new`를 사용하지 않고 Collection 인스턴스의 `iterator()`를 통해 내부적으로 생성한다

```java
ArrayList list = new ArrayList();
Iterator iter = list.iterator();
```



 **ArrayList의 Iterator 구현**

```java
public class ArrayList<E> extends AbstractList<E> implements List<E>, RandomAccess, Cloneable, java.io.Serializable
{
  //..
  public Iterator<E> iterator() {
    return new Itr(); //내부 클래스 => 내부 데이터에 접근 가능
  }
 
  private class Itr implements Iterator<E> {
    int cursor;       // 리턴할 다음 index.
    int lastRet = -1; // 가장 마지막에 리턴한 요소의 index. 없을 경우 -1리턴
    int expectedModCount = modCount;  
 
    Itr() {}
 
    public boolean hasNext() {
        return cursor != size;
    }
 
    @SuppressWarnings("unchecked")
    public E next() {
        checkForComodification();
        int i = cursor;
        if (i >= size)
            throw new NoSuchElementException();
        Object[] elementData = ArrayList.this.elementData;
        if (i >= elementData.length)
            throw new ConcurrentModificationException();
        cursor = i + 1;
        return (E) elementData[lastRet = i];
    }
}
```

**사용 예시**

```java
public void method(){
  List<String> list = new ArrayList<>();
  list.add("a");
  list.add("b");
  list.add("c");
 
  Iterator<String> it = list.iterator();
  while(it.hasNext()){
    String s = it.next();
    System.out.println(s);
  }
}
```

* hasNext(): 다음 요소가 있는지 Boolean 타입으로 반환
* next(): 다음 요소를 반환



## 참고

<a href="https://javanitto.tistory.com/10" target="_blank">[ JAVA ] Iterator 분석 (feat. ArrayList)</a>

<a href="https://digiconfactory.tistory.com/entry/%EC%9E%90%EB%B0%94-%ED%8A%9C%ED%86%A0%EB%A6%AC%EC%96%BC-12-3-Iterator-ArrayList-%EC%BB%AC%EB%A0%89%EC%85%98-%ED%94%84%EB%A0%88%EC%9E%84%EC%9B%8C%ED%81%AC" target="_blank">자바 튜토리얼 12 - 4 | Iterator, ArrayList | 컬렉션 프레임워크 |</a>
