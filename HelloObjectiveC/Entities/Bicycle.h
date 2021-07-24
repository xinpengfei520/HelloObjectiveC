//
//  Bicycle.h
//  HelloObjectiveC
//
//  Created by PengfeiXin on 2021/7/24.
//

#import <Foundation/Foundation.h>
#import "StreetLegal.h"

@interface Bicycle : NSObject <StreetLegal>

- (void)startPedaling;
- (void)removeFrontWheel;
- (void)lockToStructure:(id)theStructure;

@end
