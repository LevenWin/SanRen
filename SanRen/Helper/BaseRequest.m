//
//  BaseRequest.m
//  MVVM_Test
//
//  Created by Leven on 16/3/25.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import "BaseRequest.h"

@implementation BaseRequest
+(BOOL)netWorkReachablityWithUrlString:(NSString *)strUrl{
    __block BOOL netState=NO;
    AFHTTPRequestOperationManager *manager=[[AFHTTPRequestOperationManager alloc]initWithBaseURL:[NSURL URLWithString:strUrl]];

    NSOperationQueue *operationQuene =manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                netState=NO;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            case AFNetworkReachabilityStatusReachableViaWWAN:
                netState=YES;
            default:
                [operationQuene setSuspended:YES];
                break;
        }
    }];
    
    [manager.reachabilityManager startMonitoring];
    return netState;
}
+(void)netRequestGETWithRequestURL: (NSString *)requestURLString WithParameter :(NSDictionary *)parameter WithSuccessBlock :(SuccessBlock)successBlock WithErrorBlock :(ErrorBlock)errorBlock WithFailureBlock :(FailureBlock)failureBlock{
    
    
    AFHTTPRequestOperationManager *manager=[[AFHTTPRequestOperationManager alloc]init];
    AFHTTPRequestOperation *op=[manager GET:requestURLString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
      /**
        这里判断有没有errorCode 
        有的话调用errorBlock（error）
        没有则调用block（dic）
       */

            successBlock(dict);

        
        [MyUIHelper dismissMsg];

//        [SVProgressHUD dismiss];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failureBlock) {
            failureBlock(nil);

        }
        [MyUIHelper dismissMsg];

//        [SVProgressHUD dismiss];

    }];
    op.responseSerializer=[AFHTTPResponseSerializer serializer];
    [op start];
}
+(void)netRequestPOSTWithRequestURL: (NSString *)requestURLString WithParameter :(NSDictionary *)parameter WithSuccessBlock :(SuccessBlock)successBlock WithErrorBlock :(ErrorBlock)errorBlock WithFailureBlock :(FailureBlock)failureBlock{
    
    AFHTTPRequestOperationManager *manager=[[AFHTTPRequestOperationManager alloc]init];
  
    AFHTTPRequestOperation *op=[manager POST:requestURLString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        /**
         这里判断有没有errorCode
         有的话调用errorBlock（error）
         没有则调用block（dic）
         */
        
        successBlock(dict);
//        [SVProgressHUD dismiss];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
//        [SVProgressHUD dismiss];

    }];
    op.responseSerializer=[AFHTTPResponseSerializer serializer];
    [op start];
}
/*
 **
 
 
 /
 */
@end
