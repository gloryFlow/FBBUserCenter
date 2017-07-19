//
//  JJDHttpApi.h
//  cocosDemo
//
//  Created by 1 on 16/9/21.
//  Copyright © 2016年 1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpClient.h"

@interface HttpApi : NSObject

+ (void)get:(NSString *)url
     params:(NSDictionary *)params
    success:(void(^)(id responseObj))success
    failure:(void(^)(HttpError * e))failure;

+ (void)post:(NSString *)url
      params:(NSDictionary *)params
     success:(void(^)(id responseObj))success
     failure:(void(^)(HttpError * e))failure;

+ (void)upload:(NSString *)url
      filePath:(NSString *)filePath
        params:(NSDictionary *)params
      progress:(void(^)(NSProgress *uploadProgress))progress
       success:(void(^)(id responseObj))success
       failure:(void(^)(HttpError * e))failure;

+ (void)down:(NSString *)url
      params:(NSDictionary *)params
    progress:(void(^)(NSProgress *downProgress))progress
     success:(void (^) (void))success
     failure:(void(^)(HttpError * e))failure;

@end
