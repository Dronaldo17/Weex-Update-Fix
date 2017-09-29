//
//  WXTextAreaComponent+ARExtend.m
//  AR_Galileo
//
//  Created by 窦静轩 on 2017/9/29.
//  Copyright © 2017年 Aresnal. All rights reserved.
//

#import "WXTextAreaComponent+ARExtend.h"
#import <objc/runtime.h>
#import <WeexSDK/WXUtility.h>
#import <WeexSDK/WXComponent.h>
#import <WeexSDK/Layout.h>

#define CorrectX 4 //textview fill text 4 pixel from left. so placeholderlabel have 4 pixel too
#define CorrectY 8 // textview fill text 8 pixel from top


const char * textViewKey = "textView";

const char * rowKey = "rows";

@interface WXTextAreaComponent ()


@property (nonatomic, strong)UIFont * threadFont;

@end


@implementation WXTextAreaComponent(ARExtend)

- (void)dealloc
{
    self.threadFont = nil;
}
-(UIActivityIndicatorView*)threadFont
{
    return objc_getAssociatedObject(self, @selector(threadFont));
}

-(void)setThreadFont:(UIFont *)threadFont
{
    objc_setAssociatedObject(self, @selector(threadFont), threadFont, OBJC_ASSOCIATION_RETAIN);
}


- (CGSize (^)(CGSize))drMeasureBlock
{
    Ivar rowsViewIvar = class_getInstanceVariable([self class], rowsViewIvar);
    
    id rowValue  = object_getIvar(self, rowsViewIvar);
    
    
    NSUInteger rows = [rowValue intValue];
    
    
    __weak typeof(self) weakSelf = self;
    return ^CGSize (CGSize constrainedSize) {
        CGSize computedSize = [[[NSString alloc] init]sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:weakSelf.threadFont.pointSize]}];
        computedSize.height = rows? computedSize.height *rows + (CorrectY + CorrectY/2):0;
        if (!isnan(weakSelf.cssNode->style.minDimensions[CSS_WIDTH])) {
            computedSize.width = MAX(computedSize.width, weakSelf.cssNode->style.minDimensions[CSS_WIDTH]);
        }
        
        if (!isnan(weakSelf.cssNode->style.maxDimensions[CSS_WIDTH])) {
            computedSize.width = MIN(computedSize.width, weakSelf.cssNode->style.maxDimensions[CSS_WIDTH]);
        }
        
        if (!isnan(weakSelf.cssNode->style.minDimensions[CSS_HEIGHT])) {
            computedSize.height = MAX(computedSize.height, weakSelf.cssNode->style.minDimensions[CSS_HEIGHT]);
        }
        
        if (!isnan(weakSelf.cssNode->style.maxDimensions[CSS_HEIGHT])) {
            computedSize.height = MIN(computedSize.height, weakSelf.cssNode->style.maxDimensions[CSS_HEIGHT]);
        }
        
        return (CGSize) {
            WXCeilPixelValue(computedSize.width),
            WXCeilPixelValue(computedSize.height)
        };
    };
    
}


- (void)drViewDidLoad
{
    Ivar textViewIvar = class_getInstanceVariable([self class], textViewKey);
    
    id  textView  = object_getIvar(self, textViewIvar);
    
    id textView = [self valueForKey:propertyName];
    
    if ([textView isKindOfClass:[UITextView class]]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.threadFont = [(UITextView*)textView font];
        });
    }
    [self drViewDidLoad];
}


@end
