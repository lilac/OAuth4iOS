//
//  OAuthSyncApi.h
//  OAuth4iOS
//
//  Created by iPhone Team on 11-12-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAuthProvider.h"
#import "OAuthToken.h"
/*
typedef struct _OAuthProvider {
    NSURL *request_token_url;
    NSURL *access_token_url;
    NSURL *authorize_url;
} OAuthProvider;
*/

@interface OAuthSyncApi : NSObject {
    id<OAuthProvider> provider;
}


@property (nonatomic, retain) id<OAuthProvider> provider;

- (id)initWithProvider:(id<OAuthProvider>)provider;

//Get request token
- (OAuthToken *)getRequestTokenWithConsumerKey:(NSString *)aConsumerKey 
							  consumerSecret:(NSString *)aConsumerSecret
            callback:(NSString *)callback;

//Get access token
- (OAuthToken *)getAccessTokenWithConsumerKey:(NSString *)aConsumerKey 
							 consumerSecret:(NSString *)aConsumerSecret 
							requestTokenKey:(NSString *)aRequestTokenKey
						 requestTokenSecret:(NSString *)aRequestTokenSecret 
									 verify:(NSString *)aVerify;

@end
