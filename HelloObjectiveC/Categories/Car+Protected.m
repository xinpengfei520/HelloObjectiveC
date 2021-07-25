//
//  Car+Protected.m
//  HelloObjectiveC
//
//  Created by PengfeiXin on 2021/7/25.
//

#import "Car+Protected.h"

@implementation Car (Protected)

- (void)prepareToDrive {
    NSLog(@"Doing some internal work to get the %@ ready to drive",
          [self model]);
}

@end
