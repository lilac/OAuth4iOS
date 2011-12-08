//
//  OAuthProvider.h
//  OAuth4iOS
//
//  Created by iPhone Team on 11-12-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAuthKey.h"

@protocol OAuthProvider <NSObject>

- (NSURL*) getRequestTokenUrl;
- (NSURL*) getAccessTokenUrl;
- (NSURL*) getAuthorizeUrl:(OAuthKey*)token;

@end
