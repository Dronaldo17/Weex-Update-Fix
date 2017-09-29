//
//  WXTextAreaComponent+ARExtend.h
//  AR_Galileo
//
//  Created by 窦静轩 on 2017/9/29.
//  Copyright © 2017年 Aresnal. All rights reserved.
//

#import <WeexSDK/WXTextAreaComponent.h>

@interface WXTextAreaComponent (ARExtend)

- (CGSize (^)(CGSize))drMeasureBlock;

- (void)drViewDidLoad;
@end
