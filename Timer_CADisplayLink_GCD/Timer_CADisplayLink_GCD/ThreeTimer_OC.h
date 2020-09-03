//
//  ThreeTimer_OC.h
//  Timer_CADisplayLink_GCD
//
//  Created by 陈嘉琳 on 2020/8/10.
//  Copyright © 2020 CJL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThreeTimer_OC : NSObject

- (void)setupNSTImer;

- (void)setupCADisplayLink;

- (void)setupGCD;

@end

NS_ASSUME_NONNULL_END
