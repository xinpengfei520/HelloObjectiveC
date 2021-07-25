//
//  Car.h
//  HelloObjectiveC
//
//  Created by PengfeiXin on 2021/7/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Car : NSObject {
    // Protected instance variables (not recommended)
}

@property (copy) NSString *model;

@property BOOL running;

- (void)drive;

+ (void)setDefaultModel:(NSString *)aModel;
/*
 Objective-C 中没有构造函数方法。相反，对象是通过在分配后立即调用方法来 初始化init的。这就是为什么实例化总是一个两步过程：分配，然后初始化。还有一个类级别的初始化方法，稍后会讨论。

 init是默认的初始化方法，但您也可以定义自己的版本来接受配置参数。自定义初始化方法没有什么特别之处——它们只是普通的实例方法，只是方法名称应始终以 init. 下面显示了一个示例性的“构造函数”方法。
 */
- (id)initWithModel:(NSString *)aModel;

- (void)startEngine;

@end

NS_ASSUME_NONNULL_END
