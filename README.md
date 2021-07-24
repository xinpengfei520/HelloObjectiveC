# HelloObjectiveC
The Objective-C programming language best practice.



## 1. Introduction



## 2. C Basics



## 3. Function



## 4. Classes



## 5. Properties

在设计良好的面向对象程序中，直接访问对象的内部状态是不好的。相反，提供方法（getter 和 setter）被用作与对象的底层数据交互的抽象，`@property`指令的目标是通过自动生成这些访问器方法来轻松创建和配置属性。它允许您在语义级别指定公共属性的行为，并为您处理实现细节。让你改变 getter 和 setter 行为的各种属性。其中一些属性决定了属性如何处理它们的底层内存。



在使用`@property`指令时，编译器为该`running` 属性生成一个 getter 和一个 setter 。默认命名约定是使用属性本身作为 getter，`set`在 setter 前加上前缀，在实例变量前加上下划线，如下所示：

```objective-c
- (BOOL)running {
    return _running;
}
- (void)setRunning:(BOOL)newValue {
    _running = newValue;
}
```

使用`@property`指令声明属性后，您可以直接调用这些方法，就好像它们包含在您的类的接口和实现文件中一样。

您还可以覆盖它们以提供自定义的 getter/setter，但这会使`@synthesize` 指令成为强制性的。但是，您应该很少需要自定义访问器，因为 `@property`属性让您可以在抽象级别执行此操作。

如果您不喜欢`@property`的默认命名约定，您可以使用`getter=`和`setter=`属性更改 getter/setter 方法名称 。一个常见的用例是布尔属性，其 getter 通常以 为前缀 `is`。

```objective-c
@property (getter=isRunning) BOOL running;
```

生成的访问器现在称为`isRunning`and `setRunning`。请注意，公共属性仍称为 `running`，这是您应该用于点符号的内容。



`readonly`属性是使属性只读的一种简单方法。它省略了 setter 方法并防止通过点符号进行赋值，但 getter 不受影响。



原子性与属性在线程环境中的行为方式有关。当您有多个线程时，有可能同时调用 setter 和 getter。这意味着 getter/setter 可能会被另一个操作中断，这可能会导致数据损坏。

原子属性锁定底层对象以防止这种情况发生，保证 get 或 set 操作使用完整的值。然而，理解这只是线程安全的一个方面很重要——使用原子属性并不一定意味着您的代码是线程安全的。

`@property`默认是原子的，这确实会产生一些开销。因此，如果您不在多线程环境中（或者您正在实现自己的线程安全），您将需要使用`nonatomic`属性覆盖此行为。

```objective-c
@property (nonatomic) NSString *model;
```

### 概括：

| 属性        | 描述                                                         |
| :---------- | :----------------------------------------------------------- |
| `getter=`   | 为 getter 方法使用自定义名称                                 |
| `setter=`   | 为 setter 方法使用自定义名称                                 |
| `readonly`  | 只读属性，不生成 setter 方法                                 |
| `nonatomic` | 不要在多线程环境中保证访问器的完整性。这比默认的原子行为更有效 |
| `strong`    | 在属性和分配的值之间创建所有权关系。这是对象属性的默认值     |
| `weak`      | 在属性和分配的值之间创建非所有权关系。使用它来防止保留循环   |
| `copy`      | 创建分配值的副本，而不是引用现有实例                         |

## 6. Methods

### 6.1 命名规范

Objective-C 方法旨在消除 API 中的所有歧义。因此，方法名称非常冗长，但不可否认的是描述性的。实现这一点归结为命名 Objective-C 方法的三个简单规则：

1. 不要缩写任何东西。
2. 在方法本身中明确说明参数名称。
3. 明确描述方法的返回值。

Objective-C 方法通过用介词描述参数来明确说明这一点。得到的API保证了方法永远不会被误解：它要么 `turnByAngle:90`或`turnToAngle:90`。



### 6.2 调用方法

1⃣️ 将对象和所需方法放在方括号中并用空格分隔来调用方法。使用冒号将参数与方法名称分开；

```objective-c
[porsche initWithModel:@"Porsche"];
```

2⃣️ 当有多个参数时，它位于初始参数之后，遵循相同的模式。每个参数都与一个标签配对，用空格与其他参数分开，并用冒号隔开：

```objective-c
[porsche initWithModel:@"Porsche" mileage:42000.0];
```

从调用的角度来看上述命名约定背后的目的会容易得多。它们使方法调用更像是一种人类语言而不是计算机语言。当您将代码搁置几个月并回来修复错误时，您会欣赏它的冗长。这种清晰性还使得使用第三方库和维护大型代码库变得更加容易。

3⃣️ 嵌套方法调用是 Objective-C 程序中的常见模式。这是将一个调用的结果传递给另一个调用的方式。从概念上讲，它与其他语言的链式方法调用完全相同，但是看起来有点不同，使用多个方括号嵌套。

```objective-c
[[Car alloc] init];
```

4⃣️ Objective-C 方法没有受保护或私有的访问修饰符，所有方法都是公共的。但是 Objective-C 提供了可让您*模拟*这些功能的替代组织范例。“私有”方法可以通过在类的实现文件中定义它们，但是在接口文件（头文件）中省略它们来创建。由于其他对象（包括子类）从不应该导入实现，因此这些方法实际上对除类本身之外的所有内容隐藏。

5⃣️ 选择器是 Objective-C 的方法名称的内部表示。它们让您将方法视为一个独立的实体，使您能够将操作与需要执行它的对象分开。



## 7. Protocols

协议是一组相关的属性和方法，可以由*任何*类实现。它们比普通的类接口更灵活，因为它们允许您在完全不相关的类中重用单个 API 声明。这使得在现有类层次结构之上表示水平关系成为可能。

协议是一种将共享属性和方法抽象到专用文件中的方法。这有助于减少冗余代码并让您动态检查对象是否支持任意一组功能。

协议可以类似的理解为 Java 中的接口。

![img](http://image.x-sir.com/protocol-overview.png)

## 8. Categories



## 9. Blocks



## 10. Exceptions



## 11. Memory Management

Objective-C 使用一种更有效的替代方法，称为对象所有权。当您开始与一个对象交互时，您就被称为*拥有* 该对象，这意味着只要您使用它，它就可以保证存在。当您完成它时，您放弃所有权，并且——如果该对象没有其他所有者——操作系统将销毁该对象并释放底层内存。

![img](http://image.x-sir.com/object-ownership.png)

保留循环，这是内存泄漏的一种形式，内存泄漏是不好的。幸运的是，解决这个问题很容易——只需告诉其中一个属性保持对另一个对象的弱引用。

![img](http://image.x-sir.com/retain-cycle.png)

```objective-c
@property (nonatomic, weak) Car *car;
```

`weak`属性的一个常见用例是父子数据结构。按照惯例，父对象应该与它的子对象保持强引用，而子对象应该将弱引用存储回父对象。弱引用也是委托设计模式的固有部分。

需要指出的是，两个对象永远不应该相互具有强引用。该`weak`属性可以在不创建保留循环的情况下保持循环关系。



副本属性`copy`是 的替代`strong`。它不是获取现有对象的所有权，而是创建您分配给该属性的任何内容的副本，然后获取该对象的所有权。只有符合[`NSCopying` 协议的](http://web.archive.org/web/20160408041457/https://developer.apple.com/library/ios/documentation/cocoa/Reference/Foundation/Protocols/NSCopying_Protocol/Reference/Reference.html#//apple_ref/occ/intf/NSCopying)对象才能使用该属性。

表示值（与连接或关系相反）的属性是复制的良好候选者。例如，开发人员通常会复制 `NSString`属性而不是强引用它们：

```objective-c
@property (nonatomic, copy) NSString *model;
```

[`NSMutableString`](http://web.archive.org/web/20160408041457/http://rypress.com/tutorials/objective-c/data-types/nsstring.html#nsmutablestring) 是`NSString`可以就地编辑的子类。如果该 `model`属性没有创建原始实例的副本，我们将能够`Nissan Versa`在第二个`NSLog()`输出中看到更改后的字符串 ( ) 。



## 12. Data Types



## Thanks 

[http://rypress.com/tutorials/objective-c/index](http://rypress.com/tutorials/objective-c/index)

or

[http://web.archive.org/web/20160403182827/http://rypress.com/tutorials/objective-c/index](http://web.archive.org/web/20160403182827/http://rypress.com/tutorials/objective-c/index)

I recommend the [Ry's Objective-C Tutorial] strongly, because it very simple and easy to learn with beginners.

[https://developer.apple.com/library/content/navigation/](https://developer.apple.com/library/content/navigation/)

The new API reference pages：

[https://developer.apple.com/reference](https://developer.apple.com/reference)

