//
//  CarModel.h
//  HelloObjectiveC
//
//  Created by PengfeiXin on 2021/7/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarModel : NSObject

@property BOOL running;

@property (getter=isRunnable) BOOL runnable;

@end

NS_ASSUME_NONNULL_END
