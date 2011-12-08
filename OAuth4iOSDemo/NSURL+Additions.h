//
//  NSURL+QAdditions.h
//  QWeiboSDK4iOS
//
//  Created on 11-1-13.
//  
//
//
//  @Author James Deng
//
//  Last updated 2011/12/6.
//  
//

#import <Foundation/Foundation.h>


@interface NSURL (Additions)

+ (NSDictionary *)parseURLQueryString:(NSString *)queryString;

+ (NSURL *)smartURLForString:(NSString *)str;

@end
