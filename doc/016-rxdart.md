---
typora-root-url: ./assets
---

# 1 简介

响应式编程，只是一套思维模式。在不同的领域有很多SDK，咱们使用的技术栈，如下：

![Screen Shot 2020-12-15 at 8.40.59 AM](/Screen%20Shot%202020-12-15%20at%208.40.59%20AM.png)

响应式编程最底层的架构：publish-subscribe模型。包含三个对象：

- 发布者
- 订阅者
- 数据流

> 发布订阅模型，观察者模式，说的都是一回事。
>
> 当然，命名规则不一样，写出来的代码结构也不同。都是障眼法！

基于[ReactiveX](http://reactivex.io/)模型，`RxDart`对Dart标准库中的Stream做了扩展，有两种StreamController的变体：

1. BehaviorSubject
2. ReplaySubject



# 2 Subject

## 2.1 BehaviorSubject

缓存最后一条数据

## 2.2 ReplaySubject

缓存所有数据

## 2.3 test

```
import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';

void main() {
  test('BehaviorSubject', () {
    var subject = BehaviorSubject<int>();
    List.generate(3, (index) => index).forEach((element) {
      subject.add(element);
    });

    subject.listen(print); // 2
    subject.listen(print); // 2
    subject.listen(print); // 2

    expect(subject.stream, emits(2));

    subject.add(3);
    subject.listen(print); // 3,3,3,3
    expect(subject.stream, emits(3));

    subject.add(4); // 4,4,4,4
  });

  test('ReplaySubject', () {
    var subject = ReplaySubject<int>();
    List.generate(3, (index) => index).forEach((element) {
      subject.add(element);
    });

    subject.listen(print); // 0,1,2
    subject.listen(print); // 0,1,2
    subject.listen(print); // 0,1,2

    expect(subject.stream, emitsInOrder(<int>[0, 1, 2]));

    subject.add(3);
    subject.listen(print); // 3,3,3; 0,1,2,3
    expect(subject.stream, emitsInOrder(<int>[0, 1, 2, 3]));

    subject.add(4); // 4,4,4,4
    expect(subject.stream, emitsInOrder(<int>[0, 1, 2, 3, 4]));
  });
}
```

# 3 List of Extension Methods

```
test('map',(){
  var subject = ReplaySubject<int>();
  List.generate(3, (index) => index).forEach((element) {
    subject.add(element);
  });
  
  expect(subject.stream.map((event) => 2 * event), emitsInOrder(<int>[0, 2, 4]));
});
```



