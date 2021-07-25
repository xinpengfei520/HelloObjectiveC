//
//  Coupe.m
//  HelloObjectiveC
//
//  Created by PengfeiXin on 2021/7/25.
//

// Coupe.m
#import "Coupe.h"
#import "Car+Protected.h"

@implementation Coupe

- (void)startEngine {
    [super startEngine];
    // Call the protected method here instead of in `drive`
    [self prepareToDrive];
}

- (void)drive {
    NSLog(@"VROOOOOOM!");
}

@end
