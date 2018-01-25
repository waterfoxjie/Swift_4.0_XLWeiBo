//
//  XLHomeInfoModel.m
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/22.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

#import "XLHomeInfoModel.h"

@implementation XLHomeInfoModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{@"wbId":@"id",
             @"wbText":@"text"
             };
}

@end
