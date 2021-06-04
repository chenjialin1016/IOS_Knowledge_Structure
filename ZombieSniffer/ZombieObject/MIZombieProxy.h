//
//  MIZombieProxy.h
//  MIStore
//
//  Created by chenjialin on 2021/4/9.
//  Copyright © 2021 MI. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MIZombieProxy : NSProxy

@property (nonatomic, assign) Class originClass;

@end

NS_ASSUME_NONNULL_END
