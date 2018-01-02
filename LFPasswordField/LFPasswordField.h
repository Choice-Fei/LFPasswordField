//
//  LFPasswordField.h
//  LoanMessage
//
//  Created by admin on 2018/1/2.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LFPasswordFieldDelegate;

@interface LFPasswordField : UIView

@property (nullable, nonatomic, weak) id<LFPasswordFieldDelegate> delegate;

/**
 *  是否密文输入，默认为YES
 */
@property (nonatomic, assign) BOOL secureTextEntry;
/**
 *  用户输入完成后是否自动取消第一响应，默认为NO
 */
@property (nonatomic, assign) BOOL autoResignWhenFinished;
/**
 *  边框宽度，默认为1
 */
@property (nonatomic, assign) CGFloat borderWidth;
/**
 *  边框圆角，默认为5
 */
@property (nonatomic, assign) CGFloat borderRaduis;
/**
 *  允许输入的数字个数，默认为6，范围在1-8之间，不在范围内的一律忽略
 */
@property (nonatomic, assign) NSInteger inputCount;
/**
 *  边框颜色，默认灰色
 */
@property (nullable, nonatomic, strong) UIColor *  borderColor;
/**
 *  文本字体，默认系统17号字
 */
@property (nullable, nonatomic, strong) UIFont  *font;
/**
 *  文本颜色，默认黑色
 */
@property (nullable, nonatomic, strong) UIColor *textColor;
/**
 * 用户输入文本
 */
@property (nullable, nonatomic, strong, readonly) NSString *text;

@end
/**
 * 密码框协议
 */
@protocol LFPasswordFieldDelegate <NSObject>

@optional

- (void)passwordFieldDidChange:(LFPasswordField *_Nullable)passwordField;

@end
