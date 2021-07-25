//
//  Motorbike.h
//  HelloObjectiveC
//
//  Created by PengfeiXin on 2021/7/25.
//

#import <Foundation/Foundation.h>

@interface Motorbike : NSObject

@property (copy) NSString *model;
@property (readonly) double odometer;

- (void)startEngine;
- (void)drive;
- (void)turnLeft;
- (void)turnRight;

@end
