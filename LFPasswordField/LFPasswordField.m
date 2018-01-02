//
//  LFPasswordField.m
//  LoanMessage
//
//  Created by admin on 2018/1/2.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "LFPasswordField.h"

@interface LFPasswordField ()<UIKeyInput>

@property (nonatomic, strong)  NSMutableString *inputText;

@end

@implementation LFPasswordField

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    };
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}
- (NSString *)text {
    if (_inputText.length == 0) {
        return nil;
    }
    return _inputText;
}
- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    [self setNeedsDisplay];
}
- (void)setBorderRaduis:(CGFloat)borderRaduis {
    _borderRaduis = borderRaduis;
    [self setNeedsDisplay];
}
- (void)setInputCount:(NSInteger)inputCount {
    if (_inputCount < 1 || _inputCount > 8) {
        return;
    }
    _inputCount = inputCount;
    [self setNeedsDisplay];
}
- (void)setFont:(UIFont *)font {
    _font = font;
    [self setNeedsDisplay];
}
- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    [self setNeedsDisplay];
}
- (void)setSecureTextEntry:(BOOL)secureTextEntry {
    _secureTextEntry = secureTextEntry;
    [self setNeedsDisplay];
}
- (void)initialize {
    _borderWidth = 1;
    _borderRaduis = 5;
    _inputCount = 6;
    _borderColor = [UIColor lightGrayColor];
    _font = [UIFont systemFontOfSize:17];
    _textColor = [UIColor blackColor];
    _secureTextEntry = YES;
    _autoResignWhenFinished = NO;
    self.inputText = [NSMutableString string];
    self.backgroundColor = [UIColor clearColor];
}
- (UIKeyboardType)keyboardType {
    return UIKeyboardTypeNumberPad;
}
- (BOOL)canBecomeFirstResponder {
    return YES;
}
#pragma mark - UIKeyInput
- (BOOL)hasText {
    return self.inputText.length > 0;
}
- (void)insertText:(NSString *)text {
    if (self.inputText.length >= _inputCount) {
        if (_autoResignWhenFinished) {
            [self resignFirstResponder];
        }
        return;
    }
    [self.inputText appendString:text];
    if (self.inputText.length >= _inputCount) {
        if (_autoResignWhenFinished) {
            [self resignFirstResponder];
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(passwordFieldDidChange:)]) {
        [self.delegate passwordFieldDidChange:self];
    }
    [self setNeedsDisplay];
}
- (void)deleteBackward {
    if (self.inputText.length > 0) {
        [self.inputText deleteCharactersInRange:NSMakeRange(self.inputText.length - 1, 1)];
        if (self.delegate && [self.delegate respondsToSelector:@selector(passwordFieldDidChange:)]) {
            [self.delegate passwordFieldDidChange:self];
        }
    }
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGFloat height = rect.size.height;
    CGFloat width = rect.size.width;
    CGSize  unitSize = CGSizeMake(width/_inputCount, height);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.borderColor setStroke];
    CGContextSetLineWidth(context, _borderWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGRect bounds = CGRectInset(rect, _borderWidth * 0.5, _borderWidth * 0.5);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:_borderRaduis];
    [[UIColor whiteColor] setFill];
    CGContextAddPath(context, bezierPath.CGPath);
    //分割线
    for (int i = 1; i < _inputCount; ++i) {
        CGContextMoveToPoint(context, i*width/_inputCount, 0);
        CGContextAddLineToPoint(context, i*width/_inputCount, height);
    }
    CGContextDrawPath(context, kCGPathFillStroke);
    //当设置密文输入时用小圆点替换数字文本
    NSDictionary *attrDic = @{NSFontAttributeName:_font,NSForegroundColorAttributeName:_textColor};
    for (int i = 0; i < self.inputText.length; i++) {
        CGRect unitRect = CGRectMake(i * unitSize.width,
                                     0,
                                     unitSize.width,
                                     unitSize.height);
        if (_secureTextEntry) {
            CGRect drawRect = CGRectInset(unitRect,
                                          (unitRect.size.width - self.font.pointSize/2) / 2,
                                          (unitRect.size.height - self.font.pointSize/2) / 2);
            CGContextAddEllipseInRect(context, drawRect);
            [[UIColor blackColor] set];
            CGContextFillPath(context);
        } else {
            NSString *subString = [_inputText substringWithRange:NSMakeRange(i, 1)];
            CGSize textSize = [subString sizeWithAttributes:attrDic];
            CGRect drawRect = CGRectInset(unitRect, (unitSize.width - textSize.width)/2, (unitSize.height - textSize.height)/2);
            [subString drawInRect:drawRect withAttributes:attrDic];
    
        }
 
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (![self isFirstResponder]) {
        [self becomeFirstResponder];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
