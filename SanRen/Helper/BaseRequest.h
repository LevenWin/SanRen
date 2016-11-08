//
//  BaseRequest.h
//  MVVM_Test
//
//  Created by Leven on 16/3/25.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SuccessBlock)(id obj);
typedef void (^FailureBlock)(id obj);
typedef void (^ErrorBlock)(id obj);
@interface BaseRequest : NSObject
+(BOOL)netWorkReachablityWithUrlString:(NSString *)strUrl;
+(void)netRequestGETWithRequestURL: (NSString *)requestURLString WithParameter :(NSDictionary *)parameter WithSuccessBlock :(SuccessBlock)successBlock WithErrorBlock :(ErrorBlock)errorBlock WithFailureBlock :(FailureBlock)failureBlock;
+(void)netRequestPOSTWithRequestURL: (NSString *)requestURLString WithParameter :(NSDictionary *)parameter WithSuccessBlock :(SuccessBlock)successBlock WithErrorBlock :(ErrorBlock)errorBlock WithFailureBlock :(FailureBlock)failureBlock;
@end
