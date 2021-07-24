//
//  main.m
//  HelloObjectiveC
//
//  Created by PengfeiXin on 2021/7/5.
//

#import <Foundation/Foundation.h>
#import "Car.h"
#import "CarModel.h"
#import "Bicycle.h"

#define PI 3.14159
#define RAD_TO_DEG(radians) (radians * (180.0 / PI))

typedef unsigned char ColorComponent;

typedef struct {
    unsigned char red;
    unsigned char green;
    unsigned char blue;
} Color;

typedef enum {
    FORD,
    HONDA,
    NISSAN,
    PORSCHE
} CarModelEnum;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        double odometer = 9200.8;
        int odometerAsInteger = (int)odometer;
        
        NSLog(@"You've driven %.1f miles", odometer);        // 9200.8
        NSLog(@"You've driven %d miles", odometerAsInteger); // 9200
        
        // double const pi = 3.14159;
        // pi = 42001.0;
        // Compiler error
        
        NSLog(@"6 + 2 = %d",  6 + 2);    // 8
        NSLog(@"6 - 2 = %d",  6 - 2);    // 4
        NSLog(@"6 * 2 = %d",  6 * 2);    // 12
        NSLog(@"6 / 2 = %d",  6 / 2);    // 3
        NSLog(@"6 %% 2 = %d", 6 % 2);    // 0
        
        int i = 0;
        NSLog(@"%d", i);    // 0
        i++;
        NSLog(@"%d", i);    // 1
        i++;
        NSLog(@"%d", i);    // 2
        
        int modelYear = 1990;
        if (modelYear < 1967) {
            NSLog(@"That car is an antique!!!");
        } else if (modelYear <= 1991) {
            NSLog(@"That car is a classic!");
        } else if (modelYear == 2013) {
            NSLog(@"That's a brand new car!");
        } else {
            NSLog(@"There's nothing special about that car.");
        }
        
        // Switch statements (only work with integral types)
        switch (modelYear) {
            case 1987:
                NSLog(@"Your car is from 1987.");
                break;
            case 1988:
                NSLog(@"Your car is from 1988.");
                break;
            case 1989:
            case 1990:
                NSLog(@"Your car is from 1989 or 1990.");
                break;
            default:
                NSLog(@"I have no idea when your car was made.");
                break;
        }
        
        // While loops
        while (i<5) {
            if (i == 3) {
                NSLog(@"Aborting the while-loop");
                break;
            }
            NSLog(@"Current year: %d", modelYear + i);
            i++;
        }
        
        // For loops
        for (int i=0; i<5; i++) {
            if (i == 3) {
                NSLog(@"Skipping a for-loop iteration");
                continue;
            }
            NSLog(@"Current year: %d", modelYear + i);
        }
        
        // For-in loops ("Fast-enumeration," specific to Objective-C)
        NSArray *models = @[@"Ford", @"Honda", @"Nissan", @"Porsche"];
        for (id model in models) {
            NSLog(@"%@", model);
        }
        
        double angle = PI / 2;              // 1.570795
        NSLog(@"%f", RAD_TO_DEG(angle));    // 90.0
        
        ColorComponent red = 255;
        ColorComponent green = 160;
        ColorComponent blue = 0;
        NSLog(@"Your paint job is (R: %hhu, G: %hhu,B:%hhu)",
              red,green,blue);
        
        Color carColor = {255, 160, 0};
        NSLog(@"Your paint job is (R: %hhu, G: %hhu, B: %hhu)",
              carColor.red, carColor.green, carColor.blue);
        
        CarModelEnum myCar = NISSAN;
        switch (myCar) {
            case FORD:
            case PORSCHE:
                NSLog(@"You like Western cars?");
                break;
            case HONDA:
            case NISSAN:
                NSLog(@"You like Japanese cars?");
                break;
            default:
                break;
        }
        
        int years[4] = {1968, 1970, 1989, 1999};
        years[0] = 1967;
        for (int i=0; i<4; i++) {
            NSLog(@"The year at index %d is: %d", i, years[i]);
        }
        
//        int year = 1967;          // Define a normal variable
//        int *pointer;             // Declare a pointer that points to an int
//        pointer = &year;          // Find the memory address of the variable
//        NSLog(@"%d", *pointer);   // Dereference the address to get its value
//        *pointer = 1990;          // Assign a new value to the memory address
//        NSLog(@"%d", year);       // Access the value via the variable
//
//        char model[5] = {'H', 'o', 'n', 'd', 'a'};
//        char *modelPointer = &model[0];
//        for (int i=0; i<5; i++) {
//            NSLog(@"Value at memory address %p is %c",
//                  modelPointer, *modelPointer);
//            modelPointer++;
//        }
//        NSLog(@"The first letter is %c", *(modelPointer - 5));
        
//        int year = 1967;
//        int *pointer = &year;
//        NSLog(@"%d", *pointer);     // Do something with the value
//        pointer = NULL;             // Then invalidate it
        
        int year = 1967;
        void *genericPointer = &year;
        int *intPointer = (int *)genericPointer;
        NSLog(@"%d", *intPointer);
        
        // C 使用 NULL，而 Objective-C 将自己的宏 , 定义nil为空对象。一个好的经验法则是
        // nil 用于保存 Objective-C 对象的变量以及 NULL使用 C 指针时
//        NSString *anObject;    // An Objective-C object
//        anObject = NULL;       // This will work
//        anObject = nil;        // But this is preferred
//        int *aPointer;         // A plain old C pointer
//        aPointer = nil;        // Don't do this
//        aPointer = NULL;       // Do this instead
        
        // 实例化是一个两步过程：首先您必须通过调用该alloc方法为对象分配一些内存，
        // 然后您需要对其进行初始化以使其可以使用。您永远不应该使用未初始化的对象。
        // 值得重申的是，所有 对象都必须存储为指针。这就是我们使用 Car *toyota
        // 而不是Car toyota 声明变量的原因
        Car *toyota = [[Car alloc] init];
        
        // 要在 Objective-C 对象上调用方法，请将实例和方法放在方括号中，用空格分隔。
        // 参数在方法名称之后传递，前面是冒号，相当于 java 的
        // toyota.setModel("Toyota Corolla");
        [toyota setModel:@"Toyota Corolla"];
        // 方式一：使用合成model和 setModel访问器方法
        NSLog(@"Created a %@", [toyota model]);
        
        // 方式二：使用方便的点语法
        toyota.model = @"Toyota Camry";
        NSLog(@"Changed the car to a %@", toyota.model);
        
        [toyota drive];
        
        // 类方法使用与实例方法相同的方括号语法，但它们必须直接在类上调用，如下所示。不能
        // 在该类的实例上调用它们（[toyota setDefaultModel:@"Model T"]会抛出错误）
        [Car setDefaultModel:@"Nissan Versa"];
        
        // Instantiating objects
        Car *nissan = [[Car alloc] init];
        NSLog(@"Created a %@", [nissan model]);
        
        Car *chevy = [[Car alloc] initWithModel:@"Chevy Corvette"];
        NSLog(@"Created a %@, too.", chevy.model);
        
        Car *delorean = [[Car alloc] initWithModel:@"DeLorean"];
                
        // Get the class of an object
        NSLog(@"%@ is an instance of the %@ class",
              [delorean model], [delorean class]);
        
        // Check an object against a class and all subclasses
        if ([delorean isKindOfClass:[NSObject class]]) {
            NSLog(@"%@ is an instance of NSObject or one "
                  "of its subclasses",
                  [delorean model]);
        } else {
            NSLog(@"%@ is not an instance of NSObject or "
                  "one of its subclasses",
                  [delorean model]);
        }
        
        // Check an object against a class, but not its subclasses
        if ([delorean isMemberOfClass:[NSObject class]]) {
            NSLog(@"%@ is a instance of NSObject",
                  [delorean model]);
        } else {
            NSLog(@"%@ is not an instance of NSObject",
                  [delorean model]);
        }
        
        // Convert between strings and classes
        if (NSClassFromString(@"Car") == [Car class]) {
            NSLog(@"I can convert between strings and classes!");
        }
        
        Car *honda = [[Car alloc] init];
        honda.running = YES;                // [honda setRunning:YES]
        NSLog(@"%d", honda.running);        // [honda running]
        
        CarModel *hondaModel = [[CarModel alloc] init];
        hondaModel.running = YES;           // [honda setRunning:YES]
        NSLog(@"%d", hondaModel.running);   // [honda running]
        
        // [hondaModel runnable] is error
        // Error: method no longer exists
        NSLog(@"%d", [hondaModel isRunnable]);
        
        // 1⃣️ OC 里面没有私有方法的概念，只有实例方法（-）和类方法（+），@interface
        // 里面声明的都是可以被外部调用的
        // 2⃣️ 冒号也是方法名的一部分，method和method:是两个不同的方法名，不是
        // overload，第二个带参数。
        
        // Protocol practice
        Bicycle *bike = [[Bicycle alloc] init];
        [bike startPedaling];
        [bike signalLeftTurn];
        [bike signalStop];
        [bike lockToStructure:nil];
        
        id <StreetLegal> mysteryVehicle = (id)[[Car alloc] init];
        if ([mysteryVehicle conformsToProtocol:@protocol(StreetLegal)]) {
            [mysteryVehicle signalLeftTurn];
        }
        
        mysteryVehicle = [[Bicycle alloc] init];
        if ([mysteryVehicle conformsToProtocol:@protocol(StreetLegal)]) {
            [mysteryVehicle signalStop];
            [mysteryVehicle signalLeftTurn];
            [mysteryVehicle signalRightTurn];
        }
    }
    return 0;
}
