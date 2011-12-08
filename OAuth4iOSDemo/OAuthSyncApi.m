//
//  OAuthSyncApi.m
//  OAuth4iOS
//
//  Created by iPhone Team on 11-12-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "OAuthSyncApi.h"
#import "OAuthKey.h"
#import "OAuthRequest.h"
#import "NSURL+Additions.h"

@implementation OAuthSyncApi

#pragma mark -
#pragma mark instance methods

@synthesize provider;

- (id)initWithProvider:(id<OAuthProvider>)aProvider {
    if (self = [super init]) {
        self.provider = aProvider;
    }
    return self;
}

+ (OAuthToken *)parseToken:(NSString *)src {
    NSDictionary *params = [NSURL parseURLQueryString:src];
	NSString *key = [params objectForKey:@"oauth_token"];
	NSString *secret = [params objectForKey:@"oauth_token_secret"];
    OAuthToken *token = [[[OAuthToken alloc] init] autorelease];
    token.key = key;
    token.secret = secret;
    return token;
}

- (OAuthToken *)getRequestTokenWithConsumerKey:(NSString *)aConsumerKey 
							  consumerSecret:(NSString *)aConsumerSecret
        callback:(NSString *)callback {
	
	NSString *url = [[provider getRequestTokenUrl] absoluteString];
	
	OAuthKey *oauthKey = [[OAuthKey alloc] init];
	oauthKey.consumerKey = aConsumerKey;
	oauthKey.consumerSecret = aConsumerSecret;
	oauthKey.callbackUrl = callback;//for example
	
	OAuthRequest *request = [[OAuthRequest alloc] init];
	NSString *retString = [request syncRequestWithUrl:url httpMethod:@"GET" oauthKey:oauthKey parameters:nil files:nil];
	
	[request release];
	[oauthKey release];
	return [OAuthSyncApi parseToken:retString];
}

- (OAuthToken *)getAccessTokenWithConsumerKey:(NSString *)aConsumerKey 
							 consumerSecret:(NSString *)aConsumerSecret 
							requestTokenKey:(NSString *)aRequestTokenKey
						 requestTokenSecret:(NSString *)aRequestTokenSecret 
									 verify:(NSString *)aVerify {
	
	NSString *url = [[provider getAccessTokenUrl] absoluteString];	
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
	return [OAuthSyncApi parseToken:retString];
}
@end
