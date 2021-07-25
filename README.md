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

类别是一种通过将类的实现扩展到许多文件来模块化类的方法。扩展提供类似的功能，但其 API 必须在*主*实现文件中声明。

除了组织大型代码库之外，类别的最常见用途之一是向内置数据类型（如`NSString` 或 `NSArray`）添加方法。这样做的好处是您不必更新现有代码来使用新的子类，但您需要非常小心不要覆盖现有功能。

对于小型个人项目，类别确实不值得麻烦，坚持使用子类和协议等标准工具将为您节省一些调试麻烦。

## 9. Blocks

块是 Objective-C 的匿名函数。它们让您可以像传递数据一样在对象之间传递任意语句，这通常比引用其他地方定义的函数更直观。此外，块被实现为*闭包*，使得捕获周围状态变得微不足道。

块提供与 C 函数大致相同的功能，但它们使用起来更加直观（在您习惯了语法之后）。它们可以被内联定义的事实使得在方法调用中使用它们变得容易，并且由于它们是闭包，因此可以毫不费力地捕获周围变量的值。

符号 ( `^`) 用于将`distanceFromRateAndTime`变量标记 为块。与函数声明一样，您需要包含返回类型和参数类型，以便编译器可以强制执行类型安全。的`^`行为方式与指针（例如，`int *aPointer`）前的星号类似，因为只有在*声明*块时才需要它，之后您可以像普通变量一样使用它。

块本身本质上是一个函数定义——没有函数名。所述`^double(double rate, double time)`签名开始一个块字面一个返回`double`，并且具有两个参数也双打（返回类型如果需要，可以省略）。任意语句可以放在花括号 ( `{}`) 内，就像普通函数一样。

在将块文字分配给 `distanceFromRateAndTime`变量后，我们可以像*调用*函数一样*调用*该变量。

如果块不带任何参数，则可以完全省略参数列表。同样，指定块文字的返回类型始终是可选的，因此您可以将符号缩短为`^ { ... }`：

```objective-c
double (^randomPercent)(void) = ^ {
    return (double)arc4random() / 4294967295;
};
NSLog(@"Gas tank is %.1f%% full", randomPercent() * 100);
```

内置[`arc4random()`](http://web.archive.org/web/20160408000822/https://developer.apple.com/library/mac/#documentation/Darwin/Reference/ManPages/man3/arc4random.3.html) 函数返回一个随机的 32 位整数。通过除以`arc4random()`( `4294967295`)的最大可能值，我们得到`0`和之间的十进制值`1`。

到目前为止，看起来块只是定义函数的一种复杂方式。但是，它们作为*闭包*实现的事实 为令人兴奋的新编程机会打开了大门。

## 10. Exceptions

异常代表程序员级别的错误，例如尝试访问不存在的数组元素。它们旨在通知开发人员发生了*意外*情况。

错误是用户级别的问题，例如尝试加载不存在的文件。由于被错误*预期* 程序的正常执行过程中，应手动检查这些种类的条件和它们发生时通知用户。

![img](http://image.x-sir.com/exceptions-vs-errors.png)

异常由[`NSException`](http://web.archive.org/web/20160408041837/https://developer.apple.com/library/mac/#documentation/Cocoa/Reference/Foundation/Classes/NSException_Class/Reference/Reference.html) 类表示。它被设计为封装异常数据的通用方法，因此您应该很少需要对其进行子类化或以其他方式定义自定义异常对象。`NSException`下面列出了 的三个主要属性。

| 财产       | 描述                                                         |
| :--------- | :----------------------------------------------------------- |
| `name`     | 一个`NSString`唯一标识例外。                                 |
| `reason`   | 一个`NSString`包含对异常的人类可读的描述。                   |
| `userInfo` | 一个`NSDictionary`其键-值对包含有关异常的额外信息。这因异常类型而异。 |

### 处理异常

将任何*可能*导致异常的代码放入`@try`块中。然后，如果抛出异常，`@catch()`则执行相应的块来处理问题。该`@finally`块被称为后，无论是否发生异常。

```objective-c
				NSArray *inventory = @[@"Honda Civic",
                               @"Nissan Versa",
                               @"Ford F-150"];
        int selectedIndex = 3;
        @try {
            NSString *car = inventory[selectedIndex];
            NSLog(@"The selected car is: %@", car);
        } @catch(NSException *theException) {
            NSLog(@"An exception occurred: %@", theException.name);
            NSLog(@"Here are some details: %@", theException.reason);
        } @finally {
            NSLog(@"Executing finally block");
        }
```

未捕获异常的默认行为是向控制台输出消息并退出程序。

Objective-C 的异常处理能力并不是最有效的，所以你应该只使用`@try`/`@catch()` 块来测试真正的异常情况。不要*不*到位的普通控制流程的工具使用。相反，使用标准`if`语句检查可预测的条件。

这意味着上面的代码片段实际上是非常糟糕的异常使用。更好的方法`selectedIndex`是确保 比 `[inventory count]`使用传统比较小：

```objective-c
if (selectedIndex < [inventory count]) {
    NSString *car = inventory[selectedIndex];
    NSLog(@"The selected car is: %@", car);
} else {
    // Handle the error
}
```

#### 内置异常:

| 异常名称                           | 描述                                   |
| :--------------------------------- | :------------------------------------- |
| `NSRangeException`                 | 当您尝试访问集合边界之外的元素时发生。 |
| `NSInvalidArgumentException`       | 在将无效参数传递给方法时发生。         |
| `NSInternalInconsistencyException` | 当内部出现意外情况时发生。             |
| `NSGenericException`               | 当您不知道还有什么可以调用异常时发生。 |

请注意，这些值是*字符串*，而不是`NSException` 子类。因此，当您寻找特定类型的异常时，您需要检查该`name`属性，如下所示：

```objective-c
...
} @catch(NSException *theException) {
    if (theException.name == NSRangeException) {
        NSLog(@"Caught an NSRangeException");
    } else {
        NSLog(@"Ignored a %@ exception", theException);
        @throw;
    }
} ...
```

`@throw`指令重新引发捕获的异常。我们在上面的代码片段中使用它来忽略所有我们不想要的异常，将它扔到下一个最高 `@try`块。

## 11. Memory Management

任何内存管理系统的目标都是通过控制其所有对象的生命周期来减少程序的内存占用。iOS 和 OS X 应用程序通过对象所有权来实现这一点，这确保对象在需要时存在，不使用时不再存在。

这种对象所有权方案是通过引用计数系统实现的，该 系统在内部跟踪每个对象有多少所有者。当你声明一个对象的所有权时，你会增加它的引用计数，当你处理完这个对象时，你会减少它的引用计数。虽然它的引用计数大于零，但保证一个对象存在，但是一旦计数达到零，操作系统就允许销毁它。



1、手动保留释放 (MRR) （Xcode 4.2 之前）；

2、自动引用计数 (ARC)，它更可靠，让您专注于应用程序的功能而不是其内存管理；



| 方法          | 行为                           |
| :------------ | :----------------------------- |
| `alloc`       | 创建一个对象并声明它的所有权。 |
| `retain`      | 声明现有对象的所有权。         |
| `copy`        | 复制一个对象并声明它的所有权。 |
| `release`     | 放弃对象的所有权并立即销毁它。 |
| `autorelease` | 放弃对象的所有权，但推迟销毁。 |

手动内存管理。关键是平衡每个`alloc`、`retain`和`copy` 与`release`或`autorelease`，否则您将在应用程序中的某个点遇到悬空指针或内存泄漏。



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

Objective-C 继承了 C 的所有原始类型，并定义了一些自己的类型。但是，应用程序还需要更高级别的工具，例如字符串、字典和日期。该[基础框架](http://web.archive.org/web/20160410053407/https://developer.apple.com/library/mac/#documentation/Cocoa/Reference/Foundation/ObjC_classic/_index.html)定义了几个类，提供典型的高级编程语言中的标准，面向对象的数据结构。

标准`alloc`/`init`模式。例如，您可以使用以下内容创建一个新 对象：`NSNumber`

```objective-c
NSNumber *twentySeven = [[NSNumber alloc] initWithInt:27];
```

但是，大多数 Foundation Framework 类也提供了相应的工厂方法，如下所示：

```objective-c
NSNumber *twentySeven = [NSNumber numberWithInt:27];
```

这`NSNumber`将为您分配一个新对象，[自动释放](http://web.archive.org/web/20160410053407/http://rypress.com/tutorials/objective-c/memory-management.html#the-autorelease-method)它并返回它。在[ARC](http://web.archive.org/web/20160410053407/http://rypress.com/tutorials/objective-c/memory-management.html#automatic-reference-counting)之前，这是创建对象的便捷方式，但在现代程序中，这两种实例化模式之间没有实际区别。

此外，数字、字符串、数组和字典可以创建为文字（例如，`@"Bill"`）。您将在 Objective-C 文献中以及本教程中看到所有三种符号。

比较对象是 Objective-C 初学者的最大陷阱之一。Objective-C 中有两种不同类型的相等比较：

- 指针比较使用`==`运算符来查看两个指针是否指向相同的内存地址（即相同的对象）。不同的对象不可能用这种比较来比较相等。
- 值比较使用类似 `isEqualToNumber:`查看两个对象是否代表相同值的方法。这*是*有可能对不同的对象来比较这种比较平等的。

通常，您会希望使用第二个选项进行更可靠的比较。相关的方法被引入并排数据类型（例如，`NSNumber`“S[比较数字](http://web.archive.org/web/20160410053407/http://rypress.com/tutorials/objective-c/data-types/nsnumber.html#comparing-numbers) 部分）。

## Thanks 

[http://rypress.com/tutorials/objective-c/index](http://rypress.com/tutorials/objective-c/index)

or

[http://web.archive.org/web/20160403182827/http://rypress.com/tutorials/objective-c/index](http://web.archive.org/web/20160403182827/http://rypress.com/tutorials/objective-c/index)

I recommend the [Ry's Objective-C Tutorial] strongly, because it very simple and easy to learn with beginners.

[https://developer.apple.com/library/content/navigation/](https://developer.apple.com/library/content/navigation/)

The new API reference pages：

[https://developer.apple.com/reference](https://developer.apple.com/reference)

