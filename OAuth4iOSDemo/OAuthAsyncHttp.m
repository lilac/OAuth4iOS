//
//  QAsyncHttp.m
//  QWeiboSDK4iOS
//
//  Created on 11-1-18.
//  
//

#import "OAuthAsyncHttp.h"
#import "OAuthMutableURLRequest.h"


@implementation OAuthAsyncHttp

- (NSURLConnection *)httpGet:(NSString *)aUrl queryString:(NSString *)aQueryString delegate:(id)aDelegare {
	
	NSMutableURLRequest *request = [OAuthMutableURLRequest requestGet:aUrl queryString:aQueryString];
	return [NSURLConnection connectionWithRequest:request delegate:aDelegare]; 
	
}

- (NSURLConnection *)httpPost:(NSString *)aUrl queryString:(NSString *)aQueryString delegate:(id)aDelegare {
	
	NSMutableURLRequest *request = [OAuthMutableURLRequest requestPost:aUrl queryString:aQueryString];
	return [NSURLConnection connectionWithRequest:request delegate:aDelegare];
}

- (NSURLConnection *)httpPostWithFile:(NSDictionary *)files url:(NSString *)aUrl queryString:(NSString *)aQueryString delegate:(id)aDelegare {
	
	NSMutableURLRequest *request = [OAuthMutableURLRequest requestPostWithFile:files url:aUrl queryString:aQueryString];
	return [NSURLConnection connectionWithRequest:request delegate:aDelegare];
}

@end
