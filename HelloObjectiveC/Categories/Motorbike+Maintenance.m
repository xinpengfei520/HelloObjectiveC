//
//  Motorbike+Maintenance.m
//  HelloObjectiveC
//
//  Created by PengfeiXin on 2021/7/25.
//

#import "Motorbike+Maintenance.h"

@implementation Motorbike (Maintenance)

- (BOOL)needsOilChange {
    return YES;
}
- (void)changeOil {
    NSLog(@"Changing oil for the %@", [self model]);
}
- (void)rotateTires {
    NSLog(@"Rotating tires for the %@", [self model]);
}
- (void)jumpBatteryUsingMotorbike:(Motorbike *)anotherMotorbike {
    NSLog(@"Jumped the %@ with a %@", [self model], [anotherMotorbike model]);
}

@end
