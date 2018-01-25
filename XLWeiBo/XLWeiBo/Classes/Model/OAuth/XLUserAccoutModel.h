//
//  XLUserAccoutModel.h
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/25.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>

@interface XLUserAccoutModel : NSObject

// 用户授权的唯一票据，用于调用微博的开放接口，同时也是第三方应用验证微博用户登录的唯一票据
@property (nonatomic, copy) NSString *accessToken;
// access_token 的生命周期，单位是秒数
@property (nonatomic, assign) NSTimeInterval expiresIn;
// 授权用户的UID
@property (nonatomic, copy) NSString *uid;

/*
 "access_token" = "2.004YlqECaCmxOD8609ab5602EIicWB";
 "expires_in" = 157679999;
 isRealName = true;
 "remind_in" = 157679999;
 uid = 1903946863;
 */
@end
