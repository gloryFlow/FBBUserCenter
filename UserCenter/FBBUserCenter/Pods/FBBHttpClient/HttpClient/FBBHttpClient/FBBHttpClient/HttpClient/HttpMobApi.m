//
//  HttpMobApi.m
//  Shundan
//
//  Created by Bruce on 2017/2/8.
//  Copyright © 2017年 VWord. All rights reserved.
//

#import "HttpMobApi.h"

@implementation HttpMobApi

+ (void)get:(NSString *)url
     params:(NSDictionary *)params
    success:(void(^)(id responseObj))success
    failure:(void(^)(HttpError * e))failure {
    
    [[HttpClient sharedInstance] getWithClientType:HttpClientTypeMob url:url params:params success:^(id responseObj) {
        success(responseObj);
    } failure:^(HttpError *e) {
        failure(e);
    }];
}

+ (void)post:(NSString *)url
      params:(NSDictionary *)params
     success:(void(^)(id responseObj))success
     failure:(void(^)(HttpError * e))failure {
    
    [[HttpClient sharedInstance] postWithClientType:HttpClientTypeMob url:url params:params success:^(id responseObj) {
        success(responseObj);
    } failure:^(HttpError *e) {
        failure(e);
    }];
}

+ (void)upload:(NSString *)url
      filePath:(NSString *)filePath
        params:(NSDictionary *)params
      progress:(void(^)(NSProgress *uploadProgress))progress
       success:(void(^)(id responseObj))success
       failure:(void(^)(HttpError * e))failure {
    
    [[HttpClient sharedInstance] uploadWithClientType:HttpClientTypeMob mimeType:UploadMimeTypeImage url:url filePath:filePath params:params progress:^(NSProgress *uploadProgress) {
        progress(uploadProgress);
    } success:^(id responseObj) {
        success(responseObj);
    } failure:^(HttpError *e) {
        failure(e);
    }];
}

+ (void)down:(NSString *)url
      params:(NSDictionary *)params
    progress:(void(^)(NSProgress *downProgress))progress
     success:(void (^) (void))success
     failure:(void(^)(HttpError * e))failure {
    
    [[HttpClient sharedInstance] downloadWithClientType:HttpClientTypeMob url:url params:params progress:^(NSProgress *downProgress) {
        progress(downProgress);
    } success:^{
        success();
    } failure:^(HttpError *e) {
        failure(e);
    }];
}

@end
