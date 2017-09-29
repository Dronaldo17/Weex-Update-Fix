//
//  WeexAdapeter.m
//  AR_Galileo
//
//  Created by 窦静轩 on 2017/9/29.
//  Copyright © 2017年 Aresnal. All rights reserved.
//

#import "WeexAdapeter.h"
#import "WXTextAreaComponent+ARExtend.h"
#import <WXTextAreaComponent.h>
#import <objc/runtime.h>

@implementation WeexAdapeter


+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [[self class] exchangeWXTextAreaComponent];
        
    });
}


-(void)exchangeWXTextAreaComponent
{
    /* 替换 WXTextAreaComponent 的  loadView方法*/
    Method originalLoadView = class_getInstanceMethod([WXTextAreaComponent class], @selector(viewDidLoad));
    Method exchangeLoadView = class_getInstanceMethod([WXTextAreaComponent class], @selector(drViewDidLoad));
    method_exchangeImplementations(originalLoadView, exchangeLoadView);
 
    
    /* 替换 WXTextAreaComponent 的  measureBlock方法*/
    Method originalMeasureBlock = class_getInstanceMethod([WXTextAreaComponent class], @selector(measureBlock));
    Method exchangeMeasureBlock = class_getInstanceMethod([WXTextAreaComponent class], @selector(drMeasureBlock));
    method_exchangeImplementations(originalMeasureBlock, exchangeMeasureBlock);
    
}
@end
