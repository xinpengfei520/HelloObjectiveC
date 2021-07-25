//
//  Car.m
//  HelloObjectiveC
//
//  Created by PengfeiXin on 2021/7/6.
//

#import "Car.h"
#import "Car+Protected.h"
#import "Car+__.h"

// 虽然从技术上讲，Objective-C 中没有类级变量这样的东西，
// 但您可以通过static在定义实现之前声明一个变量来模拟一个
static NSString *_defaultModel;

@implementation Car {
    // Private instance variables
    // double _odometer;
}

@synthesize odometer = _odometer;
@synthesize model = _model;    // Optional for Xcode 4.4+
@synthesize running = _running;    // Optional for Xcode 4.4+

- (void)drive {
    // 调用的是受保护类中的方法
    [self prepareToDrive];
    NSLog(@"Driving a %@. Vrooooom!", self.model);
}

+ (void)setDefaultModel:(NSString *)aModel {
    // 创建参数的副本，而不是直接分配它。当我们在(copy)属性上使用属性时，
    // 这就是幕后发生的事情 model
    _defaultModel = [aModel copy];
}

- (id)initWithModel:(NSString *)aModel {
    self = [super init];
    if (self) {
        // Any custom setup work goes here
        _model = [aModel copy];
        _odometer = 0;
    }
    return self;
}

- (id)init {
    // Forward to the "designated" initialization method
    return [self initWithModel:_defaultModel];
}

/*
 初始化方法应始终返回对对象本身的引用，如果无法初始化，则应返回nil. 这就是为什么我们需要self在尝试使用它之前检查它是否存在。通常应该只有一个初始化方法需要这样做，其余的应该将调用转发到这个指定的初始化程序。当您有多个自定义init方法时，这会消除样板代码。

 还要注意我们是如何直接为 中的_model和 _odometer实例变量赋值的initWithModel:。请记住，这是您应该执行此操作的唯一地方之一 - 在您应该使用的其余方法中self.model和 self.odometer。
 */

/*
 该initialize方法是类级别的等价物 init。它让您有机会在任何人使用它之前设置类。例如，我们可以使用它来_defaultModel 用有效值填充变量
 在initialize使用类之前，为每个类调用一次类方法。这包括 的所有子类Car，这意味着如果它的子类之一没有重新实现它，Car它将获得两次initialize调用。因此，最好使用self == [Car class] 条件来确保初始化代码只运行一次。还要注意，在类方法中，self关键字指的是类本身，而不是实例。

 Objective-C 不会强制您将方法标记为覆盖。即使init和initialize都由其超类 定义，NSObject当您在Car.m
 */
+ (void)initialize {
    if (self == [Car class]) {
        // Makes sure this isn't executed more than once
        _defaultModel = @"Nissan Versa";
    }
}

- (void)startEngine {
    NSLog(@"Starting the %@'s engine", _model);
}

- (BOOL)engineIsWorking {
    // In the real world, this would probably return a useful value
    return YES;
}

- (void)driveForDuration:(double)duration
       withVariableSpeed:(double (^)(double time))speedFunction
                   steps:(int)numSteps {
    double dt = duration / numSteps;
    for (int i=1; i<=numSteps; i++) {
        _odometer += speedFunction(i*dt) * dt;
    }
}

@end
