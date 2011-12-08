//
//  @Author James Deng
//
//  Last updated 2011/12/6.
//  
//

#import "OAuthSyncHttp.h"
#import "OAuthMutableURLRequest.h"


@implementation OAuthSyncHttp

#pragma mark -
#pragma mark private methods

- (NSString *)getResponseWithRequest:(NSURLRequest *)request {
	
	NSURLResponse *response = nil;
	NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
	NSString *retString = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
	NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
	
	NSLog(@"response code:%d string:%@", httpResponse.statusCode, retString);
	
	return retString;
}

#pragma mark -
#pragma mark instance methods

- (NSString *)httpGet:(NSString *)aUrl queryString:(NSString *)aQueryString {
	
	NSMutableURLRequest *request = [OAuthMutableURLRequest requestGet:aUrl queryString:aQueryString];
	return [self getResponseWithRequest:request];
}

- (NSString *)httpPost:(NSString *)aUrl queryString:(NSString *)aQueryString {
	
	NSMutableURLRequest *request = [OAuthMutableURLRequest requestPost:aUrl queryString:aQueryString];
	return [self getResponseWithRequest:request];
}

- (NSString *)httpPostWithFile:(NSDictionary *)files url:(NSString *)aUrl queryString:(NSString *)aQueryString {
	
	NSMutableURLRequest *request = [OAuthMutableURLRequest requestPostWithFile:files url:aUrl queryString:aQueryString];
	return [self getResponseWithRequest:request];
}

@end
