//
//  CarStore.m
//  HelloObjectiveC
//
//  Created by PengfeiXin on 2021/7/25.
//

#import "CarStore.h"

@implementation CarStore {
    NSMutableArray *_inventory;
}

- (NSMutableArray *)inventory {
    return _inventory;
}

- (void)setInventory:(NSMutableArray *)newInventory {
    _inventory = newInventory;
    // _inventory = [newInventory retain];
    // 这确保inventory对象在superstore使用时不会被释放 。
    // 请注意，该retain方法返回对象本身，这让我们可以在一行中执行保留和赋值。
}

@end
