//
//  NSString+Encoding.h
//  QWeiboSDK4iOS
//
//  Created on 11-1-12.
//  
//
//
//  @Author James Deng
//
//  Last updated 2011/12/6.
//  
//

#import <Foundation/Foundation.h>


@interface NSString (OAEncoding)

- (NSString *)URLEncodedString;

- (NSString *)URLDecodedString;

@end
