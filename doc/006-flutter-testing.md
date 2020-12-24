---
typora-root-url: ./assets
---

# 1 简介

- 单元测试。测试一个函数（或class），是否满足要求
  - 如果函数有外部依赖，则，mock
  - 不会操作磁盘/文件/数据库等
  - 不需要运行整个应用程序，渲染页面
  - 不需要与用户交互
  - 不接收用户输入的数据或事件
- widget测试。测试单个widget是否满足预期的UI和Event（页面/外观，交互行为）
  - 用测试代码实例化widget，然后，使用代码模拟用户的操作
  - 不需要在真实设备或OS仿真器上运行
  - 一个widget的上下文可能涉及多个class，必须提供这些上下文，才可以测试
  - 上下文环境，也可以mock
- 集成测试。验证App是否流畅
  - 可以是多个widget测试，验证某个比较完整的业务流程
  - 也可以是在真实设备上运行，人工操作
  - 也可以验证App的性能

# 2 单元测试

学习dart的时候，我们就是使用单元测试，验证了dart的语法特性

- 测试文件放在test目录下
- test目录与lib目录平级
- 测试文件必须是`*_test.dart`

## 2.1 dependency

```
dev_dependencies:
  test: ^1.15.4
  mockito: ^4.1.3
```

- `dev_dependencies`，配置测试代码需要的依赖
- `test`
- `mockito` 

## 2.2 demo

```
import 'package:test/test.dart';

void main() {
  group('Single subscription streams', () {
    Stream<int> stream;
    setUp(() {
      stream = Stream.fromIterable([1, 2, 3]);
    });
    test('foreach', () async {
      await stream.forEach(print);
    });
    test('listen', () {
      stream.listen(print);
    });
    test('end signal', () {
      expect(stream, emitsInOrder([1, 2, 3, emitsDone]));
    });
  });

  group('stream functions', () {
    test('`number * 2` on each element of `Stream(1,2,3)`', () {
      var stream = Stream.fromIterable([1, 2, 3]).map((x) => x * 2);
      expect(stream, emitsInOrder([2, 4, 6]));
    });

    test('map & flatmap', () {
      var stream = Stream.fromIterable(
      ['379846260178602', '4333630359166455', '5168101164994280']
      )
      .map((element) => [element.substring(0,4), element.substring(element.length - 4)])
      .expand((element) => element);
      
      expect(stream, emitsInOrder(['3798','8602','4333','6455','5168','4280']));
    });
  });
}
```

## 2.3 使用mockito

模拟 `http.Client` 

1. 源码

```
class PostMessage{
  String to; //email address
  String subject;
  String body;
  
  PostMessage.fromJson(Map<String, dynamic> json)
      : to = json['to'],
        subject = json['subject'],
        body = json['body'];
  Map<String, dynamic> toJson() =>
    {
      'to': to,
      'subject': subject,
      'body': body,
    };
}
Future<Post> fetchPost(http.Client client) async {
  final response = await client.get('https://163.com/posts/1');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return PostMessage.fromJson(jsonDecode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
```

2. mock

```
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

// Create a MockClient using the Mock class provided by the Mockito package.
// Create new instances of this class in each test.
class MockClient extends Mock implements http.Client {}

main() {
  group('fetchPost', () {
    test('returns a Post if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get('https://163.com/posts/1'))
          .thenAnswer((_) async => http.Response('{"subject": "Test"}', 200));

      expect(await fetchPost(client), isA<Post>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get('https://163.com/posts/1'))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchPost(client), throwsException);
    });
  });
}

```


# 3 State的生命周期

![img](/watermark.png)

1. Mock util file `custom_mock.dart`

```
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mockito/mockito.dart';

class HookTest<R> extends Hook<R> {
  // ignore: prefer_const_constructors_in_immutables
  HookTest({
    this.build,
    this.dispose,
    this.initHook,
    this.didUpdateHook,
    this.reassemble,
    this.createStateFn,
    this.didBuild,
    this.deactivate,
    List<Object> keys,
  }) : super(keys: keys);

  final R Function(BuildContext context) build;
  final void Function() dispose;
  final void Function() didBuild;
  final void Function() initHook;
  final void Function() deactivate;
  final void Function(HookTest<R> previousHook) didUpdateHook;
  final void Function() reassemble;
  final HookStateTest<R> Function() createStateFn;

  @override
  HookStateTest<R> createState() => createStateFn != null ? createStateFn() : HookStateTest<R>();
}

class HookStateTest<R> extends HookState<R, HookTest<R>> {
  @override
  void initHook() {
    super.initHook();
    if (hook.initHook != null) {
      hook.initHook();
    }
  }

  @override
  void dispose() {
    if (hook.dispose != null) {
      hook.dispose();
    }
  }

  @override
  void didUpdateHook(HookTest<R> oldHook) {
    super.didUpdateHook(oldHook);
    if (hook.didUpdateHook != null) {
      hook.didUpdateHook(oldHook);
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    if (hook.reassemble != null) {
      hook.reassemble();
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    if (hook.deactivate != null) {
      hook.deactivate();
    }
  }

  @override
  R build(BuildContext context) {
    if (hook.build != null) {
      return hook.build(context);
    }
    return null;
  }
}
class MockBuild<T> extends Mock {
  T call(BuildContext context);
}

class MockInitHook extends Mock {
  void call();
}
class MockDispose extends Mock {
  void call();
}
```

2. 测试

```
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../common/custom_mock.dart';

void main() {
  final build = MockBuild<int>();
  final dispose = MockDispose();

  tearDown(() {
    reset(build);
    reset(dispose);
  });

  group('life-cycles', () {
    setUp(() {
      when(build(any)).thenReturn(42);
    });

    testWidgets('life-cycles in order', (tester) async {
      int result;
      HookTest<int> hook;
      await tester.pumpWidget(HookBuilder(
        builder: (context) {
          hook = HookTest<int>(
            build: build,
            dispose: dispose,
          );
          result = use(hook);
          return Container();
        },
      ));

      expect(result, 42);

      // verifyNoMoreInteractions(build);
      verifyNoMoreInteractions(dispose);

      final context = tester.element(find.byType(HookBuilder));
      verify(build(context)).called(1);

      verifyNoMoreInteractions(build);
      verifyNoMoreInteractions(dispose);

      verifyNever(dispose());
      await tester.pumpWidget(const SizedBox());
      //tester.pumpWidget，每次只能构建一个widget。构建新的widget时，会自动dispose上一个widget
      verify(dispose()).called(1);
      verifyNever(build(context));

      verifyNoMoreInteractions(build);
      verifyNoMoreInteractions(dispose);
    });
  });
}
```

# 4  widget测试

测试 widget ，我们需要使用 [`flutter_test`](https://api.flutter-io.cn/flutter/flutter_test/flutter_test-library.html) package 提供的额外工具，这些工具是跟 Flutter SDK 一起发布的。

## 4.1 BuildContext

构建每一个`widget`，都需要参数`BuildContext`

```
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('simple build',(){
    test('builder required',(){
      expect(
        // ignore: missing_required_param, prefer_const_constructors
          () => HookBuilder(),
        throwsAssertionError,
      );
    });
  });
}
```

## 4.2 Text widget

验证Text组件的属性：label, textDirection

```
group('find properties of the Text-Widget', () {
  HookBuilder builder(TextDirection textDirection) => HookBuilder(builder: (context) {
        final state = useState(42).value;
        return Text('$state', textDirection: textDirection);
      });
  testWidgets('find text by value', (tester) async {
    //加载widget
    await tester.pumpWidget(builder(TextDirection.ltr));
    expect(find.text('42'), findsOneWidget);
  });
  testWidgets('Text semantics', (tester) async {
    await tester.pumpWidget(builder(TextDirection.rtl));
    expect(
        tester.getSemantics(find.byType(Text)),
        matchesSemantics(
          label: '42', //有没有很意外？为什么不是24呢？
          textDirection: TextDirection.rtl,
        )
    );
  });
});
```

## 4.3 mock function

```
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class Func1<T, R> extends Mock{
  R call(T value);
}

testWidgets('build widget function',(tester) async {
  final fn = Func1<BuildContext, Widget>();
  when(fn.call(any)).thenAnswer((_) {
    return Container();
  });
  final createBuilder = () => HookBuilder(builder: fn.call);
  await tester.pumpWidget(createBuilder());

  // verifyNever(fn.call(any));
  // verify(fn.call(any)).called(1);

  verify(fn.call(any)).called(1);
  verifyNever(fn.call(any));
});
```

## 4.4 mounted

### 4.4.1 debug widget properties

```
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  testWidgets('debug widget properties', (tester) async {
    await tester.pumpWidget(
      HookBuilder(
        builder: (context){
          useIsMounted();
          return const SizedBox();
        },
      )
    );

    final element = tester.element(find.byType(HookBuilder));
    /*for(var style in DiagnosticsTreeStyle.values){
      if(style != DiagnosticsTreeStyle.none){
        print(element.toDiagnosticsNode(style: style).toStringDeep());
      }
      print('=========${style}=========');
    }*/
    expect(element.toDiagnosticsNode(style: DiagnosticsTreeStyle.offstage).toStringDeep(),
      equalsIgnoringHashCodes(
        'HookBuilder\n'
            ' │ useIsMounted: true\n'
            ' └SizedBox(renderObject: RenderConstrainedBox#00000)\n',
      ),
    );
  });
}
```

### 4.4.2 useIsMounted

```
testWidgets('useIsMounted', (tester) async {
  IsMounted isMounted;
  await tester.pumpWidget(
      HookBuilder(
        builder: (context){
          isMounted = useIsMounted();
          return const SizedBox();
        },
      )
  );
  expect(isMounted(), true);

  await tester.pumpWidget(const SizedBox());
  expect(isMounted(), false);
});
```

## 4.5 multiple Text widget

### 4.5.1 目标widget

```
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Hello extends HookWidget {
  final String title;
  final String message;

  const Hello({Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hooks Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}
```

### 4.5.2 test

```
import 'package:flutter_study/src/hooks/ui/hello.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Hello Widget has a title and message', (tester) async {
    await tester.pumpWidget(Hello(title: 'hello', message: 'welcome yuri',));

    final titleFinder = find.text('hello');
    final messageFinder = find.text('welcome yuri');

    expect(titleFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });
}
```

## 4.6 Events

目的：测试文本输入、点击、拖动等事件

### 4.6.1 story

1. 创建待测 Widget
2. 在文本区输入文本
3. 点击按钮，增加待办清单项
4. 滑动删除待办清单项

### 4.6.2 Create a widget to test

```
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TodoList extends HookWidget {
  const TodoList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todos = useState(<String>[]);
    final controller = useTextEditingController();

    final listView = ListView.builder(
      itemCount: todos.value.length,
      itemBuilder: (BuildContext context, int index) {
        if (index < 0) {
          return null;
        }
        final todo = todos.value[index];

        return Dismissible(
          key: Key('$todo$index'),
          onDismissed: (direction) => todos.value.removeAt(index),
          child: ListTile(title: Text(todo)),
          background: Container(color: Colors.red),
        );
      },
    );

    return MaterialApp(
      title: 'todo list',
      home: Scaffold(
        appBar: AppBar(
          title: Text('WeBooking'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
            ),
            Expanded(
              child: listView,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              todos.value.add(controller.text);
              // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
              todos.notifyListeners();
              controller.clear();
            }
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

```

### 4.6.3 测试TextField

```
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/src/hooks/ui/todo_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Enter 'hi' into the TextField", (tester) async {
    await tester.pumpWidget(TodoList());

    var finder = find.byType(TextField);
    await tester.enterText(finder, 'hi');

    expect(find.text('hi'), findsOneWidget);

    var widget = tester.widget(finder) as TextField;
    // print(widget.toDiagnosticsNode(
    //   style: DiagnosticsTreeStyle.offstage
    // ).toStringDeep());
    expect(widget.controller.text, 'hi');
  });
}
```

# 5 Integration测试

- 在真实设备或OS仿真器上运行
- 需要添加依赖`flutter_driver`

## 5.1 dev_dependencies

```
dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
  mockito: ^4.1.3
  test: any
```

## 5.2 directory `integration_test`

## 5.3 app.dart

```
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_study/main.dart' as app;

void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  // Call the `main()` function of the app or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}
```

## 5.4 app_test.dart

```
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Integration test todo_list', () {
    final textField = find.byType('TextField');

    FlutterDriver driver;
    // Connect to the Flutter driver before running any tests.
    setUp(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDown(() async {
      if (driver != null) {
        await driver.screenshot();
        await driver.close();
      }
    });
    test("Enter 'hi' into the TextField", () async {
      await driver.tap(textField); // acquire focus
      await driver.enterText('Hello!'); // enter text
      await driver.waitFor(textField); // verify text appears on UI

      expect(await driver.getText(textField), 'Hello!');
    });
  });
}

```

## 5.5 执行测试

1. 打开simulator
2. 在`terminal`中输入命令：

```
flutter drive --target=test_driver/app.dart
```
