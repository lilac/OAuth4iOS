//
//  NSString+Encoding.m
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

#import "NSString+Encoding.h"


@implementation NSString (OAEncoding)

- (NSString *)URLEncodedString 
{
    NSString *result = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,                                                                           (CFStringRef)self,                                                                           NULL,												
        CFSTR("!*'();:@&=+$,/?%#[]"),                                                                           kCFStringEncodingUTF8);
    [result autorelease];
	return result;
}

- (NSString*)URLDecodedString
{
	NSString *result = (NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,																						   (CFStringRef)self,										 CFSTR(""),																						   kCFStringEncodingUTF8);
    [result autorelease];
	return result;	
}

@end
