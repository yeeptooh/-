//
//  NicoNetworking.m
//  维客报单
//
//  Created by 张冬冬 on 16/8/11.
//  Copyright © 2016年 张冬冬. All rights reserved.
//

#import "NicoNetworking.h"
#import "AFNetworking.h"
@implementation NicoNetworking

+ (void)nicoGetWithBaseURL:(NSString *)baseURL subURL:(NSString *)subURL parameters:(NSDictionary *)parameters success:(void (^) (id responseObject))success failure:(void (^) (NSError *error))failure {
    [self nicoGetWithBaseURL:baseURL subURL:subURL parameters:parameters isJSONSerialization:YES success:success failure:failure];
}

+ (void)nicoPOSTWithBaseURL:(NSString *)baseURL subURL:(NSString *)subURL parameters:(NSDictionary *)parameters success:(void (^) (id responseObject))success failure:(void (^) (NSError *error))failure {
    [self nicoPOSTWithBaseURL:baseURL subURL:subURL parameters:parameters isJSONSerialization:YES success:success failure:failure];
}

+ (void)nicoGetWithBaseURL:(NSString *)baseURL subURL:(NSString *)subURL parameters:(NSDictionary *)parameters isJSONSerialization:(BOOL)serialization success:(void (^) (id responseObject))success failure:(void (^) (NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *url = [NSString stringWithFormat:@"%@%@",baseURL, subURL];
    
    if (!serialization) {
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)nicoPOSTWithBaseURL:(NSString *)baseURL subURL:(NSString *)subURL parameters:(NSDictionary *)parameters isJSONSerialization:(BOOL)serialization success:(void (^) (id responseObject))success failure:(void (^) (NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSString *url = [NSString stringWithFormat:@"%@%@",baseURL, subURL];
    if (!serialization) {
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
