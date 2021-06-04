//
//  MIZombieSniffer.h
//  MIStore
//
//  Created by chenjialin on 2021/4/9.
//  Copyright © 2021 MI. All rights reserved.
//  zombie对象嗅探器
//  把释放的对象，全都转为僵尸对象

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MIZombieSniffer : NSObject

/*!
 *  @method installSniffer
 *  启动zombie检测
 */
+ (void)installSniffer;

/*!
 *  @method uninstallSnifier
 *  停止zombie检测
 */
+ (void)uninstallSnifier;

/*!
 *  @method appendIgnoreClass
 *  添加白名单类
 */
+ (void)appendIgnoreClass: (Class)cls;

@end

NS_ASSUME_NONNULL_END
