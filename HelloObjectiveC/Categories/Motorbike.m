//
//  Motorbike.m
//  HelloObjectiveC
//
//  Created by PengfeiXin on 2021/7/25.
//

#import <Foundation/Foundation.h>
#import "Motorbike.h"

@implementation Motorbike

@synthesize model = _model;

- (void)startEngine {
    NSLog(@"Starting the %@'s engine", _model);
}
- (void)drive {
    NSLog(@"The %@ is now driving", _model);
}
- (void)turnLeft {
    NSLog(@"The %@ is turning left", _model);
}
- (void)turnRight {
    NSLog(@"The %@ is turning right", _model);
}

@end
