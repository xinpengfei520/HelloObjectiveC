//
//  CarStore.h
//  HelloObjectiveC
//
//  Created by PengfeiXin on 2021/7/25.
//

#import <Foundation/Foundation.h>

@interface CarStore : NSObject

- (NSMutableArray *)inventory;
- (void)setInventory:(NSMutableArray *)newInventory;

@end
