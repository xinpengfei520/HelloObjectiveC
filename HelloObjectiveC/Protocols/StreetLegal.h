//
//  StreetLegal.h
//  HelloObjectiveC
//
//  Created by PengfeiXin on 2021/7/24.
//  我们的协议将捕捉街头合法车辆的必要行为。
//  在协议中定义这些特征可以让您将它们应用于任意对象，而不是强制它们从同一个抽象超类继承。
//  任何采用此协议的对象都保证实现上述所有方法。
//  任何符合StreetLegal协议的对象也必须符合NSObject协议。
//

#import <Foundation/Foundation.h>

@protocol StreetLegal <NSObject>

- (void)signalStop;
- (void)signalLeftTurn;
- (void)signalRightTurn;

@end
