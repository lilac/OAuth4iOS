//
//  QWeiboSyncApi.m
//  QWeiboSDK4iOSDemo
//
//  Created on 11-1-13.
//   
//

#import "QWeiboSyncApi.h"
#import "OAuthKey.h"
#import "OAuthRequest.h"


@implementation QWeiboSyncApi

#pragma mark -
#pragma mark instance methods

- (NSString *)getRequestTokenWithConsumerKey:(NSString *)aConsumerKey 
							  consumerSecret:(NSString *)aConsumerSecret {
	
	NSString *url = @"https://open.t.qq.com/cgi-bin/request_token";//for example
	
	OAuthKey *oauthKey = [[OAuthKey alloc] init];
	oauthKey.consumerKey = aConsumerKey;
	oauthKey.consumerSecret = aConsumerSecret;
	oauthKey.callbackUrl = @"http://www.qq.com";//for example
	
	OAuthRequest *request = [[OAuthRequest alloc] init];
	NSString *retString = [request syncRequestWithUrl:url httpMethod:@"GET" oauthKey:oauthKey parameters:nil files:nil];
	
	[request release];
	[oauthKey release];
	return retString;
}

- (NSString *)getAccessTokenWithConsumerKey:(NSString *)aConsumerKey 
							 consumerSecret:(NSString *)aConsumerSecret 
							requestTokenKey:(NSString *)aRequestTokenKey
						 requestTokenSecret:(NSString *)aRequestTokenSecret 
									 verify:(NSString *)aVerify {
	
	NSString *url = @"https://open.t.qq.com/cgi-bin/access_token";
	
	OAuthKey *oauthKey = [[OAuthKey alloc] init];
	oauthKey.consumerKey = aConsumerKey;
	oauthKey.consumerSecret = aConsumerSecret;
	oauthKey.tokenKey = aRequestTokenKey;
	oauthKey.tokenSecret= aRequestTokenSecret;
	oauthKey.verify = aVerify;
	
	OAuthRequest *request = [[OAuthRequest alloc] init];
	NSString *retString = [request syncRequestWithUrl:url httpMethod:@"GET" oauthKey:oauthKey parameters:nil files:nil];
	
	[request release];
	[oauthKey release];
	return retString;
}

- (NSString *)getHomeMsgWithConsumerKey:(NSString *)aConsumerKey
						 consumerSecret:(NSString *)aConsumerSecret 
						 accessTokenKey:(NSString *)aAccessTokenKey 
					  accessTokenSecret:(NSString *)aAccessTokenSecret 
							 resultType:(ResultType)aResultType 
							  pageFlage:(PageFlag)aPageFlag 
								nReqNum:(NSInteger)aReqNum {
	
	NSString *url = @"http://open.t.qq.com/api/statuses/home_timeline";
	
	OAuthKey *oauthKey = [[OAuthKey alloc] init];
	oauthKey.consumerKey = aConsumerKey;
	oauthKey.consumerSecret = aConsumerSecret;
	oauthKey.tokenKey = aAccessTokenKey;
	oauthKey.tokenSecret= aAccessTokenSecret;
	
	NSString *format = nil;
	if (aResultType == RESULTTYPE_XML) {
		format = @"xml";
	} else if (aResultType == RESULTTYPE_JSON) {
		format = @"json";
	} else {
		format = @"json";
	}
	
	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
	[parameters setObject:format forKey:@"format"];
	[parameters setObject:[NSString stringWithFormat:@"%d", aPageFlag] forKey:@"pageflag"];
	[parameters setObject:[NSString stringWithFormat:@"%d", aReqNum] forKey:@"reqnum"];
		
	OAuthRequest *request = [[OAuthRequest alloc] init];
	NSString *retString = [request syncRequestWithUrl:url httpMethod:@"GET" oauthKey:oauthKey parameters:parameters files:nil];
	
	[request release];
	[oauthKey release];
	return retString;
}

- (NSString *)publishMsgWithConsumerKey:(NSString *)aConsumerKey 
						 consumerSecret:(NSString *)aConsumerSecret 
						 accessTokenKey:(NSString *)aAccessTokenKey 
					  accessTokenSecret:(NSString *)aAccessTokenSecret 
								content:(NSString *)aContent 
							  imageFile:(NSString *)aImageFile 
							 resultType:(ResultType)aResultType {
	
	NSMutableDictionary *files = [NSMutableDictionary dictionary];
	NSString *url;
	
	if (aImageFile) {
		url = @"http://open.t.qq.com/api/t/add_pic";
		[files setObject:aImageFile forKey:@"pic"];
	} else {
		url = @"http://open.t.qq.com/api/t/add";
	}
	
	OAuthKey *oauthKey = [[OAuthKey alloc] init];
	oauthKey.consumerKey = aConsumerKey;
	oauthKey.consumerSecret = aConsumerSecret;
	oauthKey.tokenKey = aAccessTokenKey;
	oauthKey.tokenSecret= aAccessTokenSecret;
	
	NSString *format = nil;
	if (aResultType == RESULTTYPE_XML) {
		format = @"xml";
	} else if (aResultType == RESULTTYPE_JSON) {
		format = @"json";
	} else {
		format = @"json";
	}
	
	NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
	[parameters setObject:aContent forKey:@"content"];
	[parameters setObject:@"127.0.0.1" forKey:@"clientip"];
	
	OAuthRequest *request = [[OAuthRequest alloc] init];
	NSString *retString = [request syncRequestWithUrl:url httpMethod:@"POST" oauthKey:oauthKey parameters:parameters files:files];
	
	[request release];
	[oauthKey release];
	return retString;

}

@end
