//
//  function.m
//  HelloObjectiveC
//
//  Created by PengfeiXin on 2021/7/5.
//

#import <Foundation/Foundation.h>

int getRandomInteger(int minimum, int maximum) {
    return arc4random_uniform((maximum - minimum) + 1) + minimum;
}

//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        int randomNumber = getRandomInteger(-10, 10);
//        NSLog(@"Selected a random number between -10 and 10: %d",
//              randomNumber);
//    }
//    return 0;
//}

//NSString *getRandomMake(NSArray *makes) {
//    int maximum = (int)[makes count];
//    int randomIndex = arc4random_uniform(maximum);
//    return makes[randomIndex];
//}
//
//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        NSArray *makes = @[@"Honda", @"Ford", @"Nissan", @"Porsche"];
//        NSLog(@"Selected a %@", getRandomMake(makes));
//    }
//    return 0;
//}

// Declaration
//NSString *getRandomMake(NSArray *);
//
//int main(int argc, const char * argv[]) {
//    @autoreleasepool {
//        NSArray *makes = @[@"Honda", @"Ford", @"Nissan", @"Porsche"];
//        NSLog(@"Selected a %@", getRandomMake(makes));
//    }
//    return 0;
//}
//
//// Implementation
//NSString *getRandomMake(NSArray *makes) {
//    int maximum = (int)[makes count];
//    int randomIndex = arc4random_uniform(maximum);
//    return makes[randomIndex];
//}
