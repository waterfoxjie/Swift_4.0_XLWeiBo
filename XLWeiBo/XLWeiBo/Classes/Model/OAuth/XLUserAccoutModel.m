//
//  XLUserAccoutModel.m
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/25.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

#import "XLUserAccoutModel.h"

@implementation XLUserAccoutModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{@"accessToken":@"access_token",
             @"expiresIn":@"expires_in",
             @"uid":@"uid"
             };
}

@end
