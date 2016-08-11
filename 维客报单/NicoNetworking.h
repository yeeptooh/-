//
//  NicoNetworking.h
//  维客报单
//
//  Created by 张冬冬 on 16/8/11.
//  Copyright © 2016年 张冬冬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NicoNetworking : NSObject

+ (void)nicoGetWithBaseURL:(NSString *)baseURL subURL:(NSString *)subURL parameters:(NSDictionary *)parameters isJSONSerialization:(BOOL)serialization success:(void (^) (id responseObject))success failure:(void (^) (NSError *error))failure;

+ (void)nicoPOSTWithBaseURL:(NSString *)baseURL subURL:(NSString *)subURL parameters:(NSDictionary *)parameters isJSONSerialization:(BOOL)serialization success:(void (^) (id responseObject))success failure:(void (^) (NSError *error))failure;

+ (void)nicoGetWithBaseURL:(NSString *)baseURL subURL:(NSString *)subURL parameters:(NSDictionary *)parameters success:(void (^) (id responseObject))success failure:(void (^) (NSError *error))failure;

+ (void)nicoPOSTWithBaseURL:(NSString *)baseURL subURL:(NSString *)subURL parameters:(NSDictionary *)parameters success:(void (^) (id responseObject))success failure:(void (^) (NSError *error))failure;

@end
