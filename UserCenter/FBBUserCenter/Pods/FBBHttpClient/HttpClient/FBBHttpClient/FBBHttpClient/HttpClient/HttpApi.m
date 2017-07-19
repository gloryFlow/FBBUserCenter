//
//  JJDHttpApi.m
//  cocosDemo
//
//  Created by 1 on 16/9/21.
//  Copyright © 2016年 1. All rights reserved.
//

#import "HttpApi.h"

@implementation HttpApi

+ (void)get:(NSString *)url
     params:(NSDictionary *)params
    success:(void(^)(id responseObj))success
    failure:(void(^)(HttpError * e))failure {
    
    [[HttpClient sharedInstance] getWithClientType:HttpClientTypeDefault url:url params:params success:^(id responseObj) {
        success(responseObj);
    } failure:^(HttpError *e) {
        failure(e);
    }];
}

+ (void)post:(NSString *)url
      params:(NSDictionary *)params
     success:(void(^)(id responseObj))success
     failure:(void(^)(HttpError * e))failure {
    
    [[HttpClient sharedInstance] postWithClientType:HttpClientTypeDefault url:url params:params success:^(id responseObj) {
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

    [[HttpClient sharedInstance] uploadWithClientType:HttpClientTypeDefault mimeType:UploadMimeTypeImage url:url filePath:filePath params:params progress:^(NSProgress *uploadProgress) {
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
    
    [[HttpClient sharedInstance] downloadWithClientType:HttpClientTypeDefault url:url params:params progress:^(NSProgress *downProgress) {
        progress(downProgress);
    } success:^{
        success();
    } failure:^(HttpError *e) {
        failure(e);
    }];
}

@end
