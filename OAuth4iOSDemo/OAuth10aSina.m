//
//  OAuth10aSina.m
//  OAuth4iOS
//
//  Created by iPhone Team on 11-12-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "OAuth10aSina.h"
#import "OAuthKey.h"

@implementation OAuth10aSina

- (NSURL*) getRequestTokenUrl {
    return [NSURL URLWithString:@"http://api.t.sina.com.cn/oauth/request_token"];
}
- (NSURL*) getAccessTokenUrl {
    return [NSURL URLWithString:@"http://api.t.sina.com.cn/oauth/access_token"];
}
- (NSURL*) getAuthorizeUrl:(OAuthKey*)token {
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://api.t.sina.com.cn/oauth/authorize?oauth_token=%@", token.tokenKey]];
}
@end
