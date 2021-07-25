//
//  Motorbike+Maintenance.h
//  HelloObjectiveC
//
//  Created by PengfeiXin on 2021/7/25.
//  Car+Maintenance.h，类别接口看起来与普通接口完全相同，只是类名后跟括号中的类别名称
//  在运行时，这些方法成为Car类的一部分。即使它们是在不同的文件中声明的，您也可以访问它们，就像它们是在原始Car.h
//  需要注意的是，类别也可用于覆盖基类中的现有方法，但您永远不应该这样做。问题在于类别是一个扁平的组织结构。
//  如果您覆盖现有方法，然后决定要使用另一个类别再次更改其行为，则
//  Objective-C 无法知道要使用哪个实现。在这种情况下，子类化几乎总是更好的选择
//

#import "Motorbike.h"

NS_ASSUME_NONNULL_BEGIN

@interface Motorbike (Maintenance)

- (BOOL)needsOilChange;
- (void)changeOil;
- (void)rotateTires;
- (void)jumpBatteryUsingMotorbike:(Motorbike *)anotherMotorbike;

@end

NS_ASSUME_NONNULL_END
