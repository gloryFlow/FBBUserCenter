//
//  HttpClient.m
//  cocosDemo
//
//  Created by 1 on 16/9/21.
//  Copyright © 2016年 1. All rights reserved.
//

#import "HttpClient.h"
#import <AFNetworking/AFNetworking.h>

#define defaultBaseUrl @"http://192.168.118.74:8888/ndasec/ndc/interfaceservice/ios/api.do"
static NSString *mobApiBaseUrl = @"http://apicloud.mob.com/";
static NSString *anotherApiBaseUrl = @"http://apicloud.mob.com/";

@implementation HttpError

@end

@interface HttpClient ()

@property (nonatomic, strong) AFHTTPSessionManager *httpManager;

@end

@implementation HttpClient

+ (instancetype)sharedInstance {
    static HttpClient *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[HttpClient alloc] init];
        _sharedInstance.httpManager = [AFHTTPSessionManager manager];
        _sharedInstance.httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sharedInstance.httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    });
    
    return _sharedInstance;
}

#pragma mark - Http Request Failure
- (HttpError *)httpRequestFailure:(NSHTTPURLResponse *)response
                            error:(NSError *)error {
    
    HttpError *e = [[HttpError alloc] init];
    if(error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorCannotFindHost || error.code == NSURLErrorCannotConnectToHost){
        e.etype = HttpErrorTypeNetWork;
        e.message = @"网络连接失败!";
        return e;
    }
    
    if (error.code == NSURLErrorTimedOut){
        e.etype = HttpErrorTypeTimeout;
        e.message = @"网路连接超时!";
        return e;
    }
    
    NSInteger statusCode = response.statusCode;
    if (statusCode == 401) {
        e.etype = HttpErrorTypeAuth;
        e.message = @"认证失败";
    } else if (statusCode == 400){
        e.etype = HttpErrorTypeBadRequest;
        e.message = @"无效请求";
    } else if (statusCode == 404) {
        e.etype = HttpErrorTypeNotFound;
        e.message = @"访问的资源丢失了!";
    } else if (statusCode >= 500){
        e.etype = HttpErrorTypeServerDown;
        e.message = @"服务器居然累倒了!";
    }
    
    return e;
}

#pragma mark - Http Get
- (void)getWithClientType:(HttpClientType)type
                      url:(NSString *)url
                   params:(NSDictionary *)params
                  success:(void(^)(id responseObj))success
                  failure:(void(^)(HttpError * e))failure {
    
    NSString *requestUrl = [self requestUrlWithPath:url clientType:type];
    
    [self.httpManager GET:requestUrl parameters:params progress:^(NSProgress *downloadProgress) {
        //获取进度
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        //成功
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //失败
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        HttpError *e = [self httpRequestFailure:httpResponse error:error];
        failure(e);
    }];
}

#pragma mark - Http post
- (void)postWithClientType:(HttpClientType)type
                       url:(NSString *)url
                    params:(NSDictionary *)params
                   success:(void(^)(id responseObj))success
                   failure:(void(^)(HttpError * e))failure {
    
    NSString *requestUrl = [self requestUrlWithPath:url clientType:type];
    
    [self.httpManager POST:requestUrl parameters:params progress:^(NSProgress *uploadProgress) {
        //获取进度
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        //成功
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //失败
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        HttpError *e = [self httpRequestFailure:httpResponse error:error];
        failure(e);
    }];
}

#pragma mark - Http upload
- (void)uploadWithClientType:(HttpClientType)type
                    mimeType:(UploadMimeType)mimeType
                         url:(NSString *)url
                    filePath:(NSString *)filePath
                      params:(NSDictionary *)params
                    progress:(void(^)(NSProgress *uploadProgress))progress
                     success:(void(^)(id responseObj))success
                     failure:(void(^)(HttpError * e))failure {
    
    NSString *requestUrl = [self requestUrlWithPath:url clientType:type];

    [self.httpManager POST:requestUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if (mimeType == UploadMimeTypeImage) {
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            [formData appendPartWithFileData:data name:@"file" fileName:@"file" mimeType:@"image/jpeg"];
        } else if (mimeType == UploadMimeTypeAudio) {
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"file" fileName:@"file" mimeType:@"audio/amr" error:nil];
        } else if (mimeType == UploadMimeTypeVideo) {
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"file" fileName:@"file" mimeType:@"video/avi" error:nil];
        }
        
    } progress:^(NSProgress *uploadProgress) {
        //打印下上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        //请求成功
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //请求失败
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        HttpError *e = [self httpRequestFailure:httpResponse error:error];
        failure(e);
    }];
}

#pragma mark - Http download
- (void)downloadWithClientType:(HttpClientType)type
                           url:(NSString *)url
                        params:(NSDictionary *)params
                      progress:(void(^)(NSProgress *downProgress))progress
                       success:(void (^) (void))success
                       failure:(void(^)(HttpError * e))failure {
    
    //2.确定请求的URL地址
    NSString *requestUrl = [self requestUrlWithPath:url clientType:type];
    
    //3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestUrl]];
    
    //下载任务
    NSURLSessionDownloadTask *task = [self.httpManager downloadTaskWithRequest:request progress:^(NSProgress * downloadProgress) {
        //打印下载进度
        NSLog(@"%lf",1.0 *downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        progress(downloadProgress);
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSLog(@"targetPath:%@",targetPath);
        //设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        return [NSURL URLWithString:filePath];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        if (!error) {
            //下载成功
            success();
        } else {
            //下载失败
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            HttpError *e = [self httpRequestFailure:httpResponse error:error];
            failure(e);
        }
    }];
    
    //开始启动任务
    [task resume];
}

#pragma mark - Http Request Url
- (NSString *)requestUrlWithPath:(NSString *)path clientType:(HttpClientType)type {
    NSString *url = path;
    if (type == HttpClientTypeDefault) {
        url = [NSString stringWithFormat:@"%@", defaultBaseUrl];
    } else if (type == HttpClientTypeMob) {
        url = [NSString stringWithFormat:@"%@%@", mobApiBaseUrl, path];
    } else if (type == HttpClientTypeAnother) {
        url = [NSString stringWithFormat:@"%@%@", anotherApiBaseUrl, path];
    }
    
    return url;
}

- (NSSet *)contentTypes {
    return [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
}

@end
