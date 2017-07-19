//
//  HttpClient.h
//  cocosDemo
//
//  Created by 1 on 16/9/21.
//  Copyright © 2016年 1. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HttpClientType) {
    HttpClientTypeDefault,  //默认API地址
    HttpClientTypeMob,      //Mob API地址
    HttpClientTypeAnother,  //其他地址
} ;

typedef NS_ENUM(NSInteger, UploadMimeType) {
    UploadMimeTypeDefault,  //默认
    UploadMimeTypeImage,    //图片
    UploadMimeTypeAudio,    //音频
    UploadMimeTypeVideo,    //视频
} ;


typedef NS_ENUM(NSInteger, HttpErrorType) {
    HttpErrorTypeDefault = 0,   //默认
    HttpErrorTypeNetWork,       //网络出错
    HttpErrorTypeTimeout,       //请求超时
    HttpErrorTypeNotFound,      //404资源不存在
    HttpErrorTypeBadRequest,    //非法请求
    HttpErrorTypeForbidRequest, //禁止访问
    HttpErrorTypeAuth,          //认证失败
    HttpErrorTypeServerDown,    //服务器出错
    
    //自定义错误码
    HttpErrorTypeNotLogin,      //未登录，无法获取资源
    HttpErrorTypeJsonParse,     //数据解析失败
} ;

@interface HttpError : NSObject

@property (nonatomic, assign) HttpErrorType etype;
@property (nonatomic, strong) NSString *message;

@end

@interface HttpClient : NSObject

@property (nonatomic, strong) NSString *baseUrl;

+ (instancetype)sharedInstance;

- (void)getWithClientType:(HttpClientType)type
                      url:(NSString *)url
                   params:(NSDictionary *)params
                  success:(void(^)(id responseObj))success
                  failure:(void(^)(HttpError * e))failure;

- (void)postWithClientType:(HttpClientType)type
                       url:(NSString *)url
                    params:(NSDictionary *)params
                   success:(void(^)(id responseObj))success
                   failure:(void(^)(HttpError * e))failure;

- (void)uploadWithClientType:(HttpClientType)type
                    mimeType:(UploadMimeType)mimeType
                         url:(NSString *)url
                    filePath:(NSString *)filePath
                      params:(NSDictionary *)params
                    progress:(void(^)(NSProgress *uploadProgress))progress
                     success:(void(^)(id responseObj))success
                     failure:(void(^)(HttpError * e))failure;

- (void)downloadWithClientType:(HttpClientType)type
                           url:(NSString *)url
                        params:(NSDictionary *)params
                      progress:(void(^)(NSProgress *downProgress))progress
                       success:(void (^) (void))success
                       failure:(void(^)(HttpError * e))failure;

@end
