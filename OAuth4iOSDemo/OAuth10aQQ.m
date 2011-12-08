//
//  OAuthQQ.m
//  OAuth4iOS
//
//  Created by iPhone Team on 11-12-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "OAuth10aQQ.h"

@implementation OAuth10aQQ

- (NSURL*) getRequestTokenUrl {
    return [NSURL URLWithString:@"https://open.t.qq.com/cgi-bin/request_token"];
}

- (NSURL*) getAccessTokenUrl {
    return [NSURL URLWithString:@"https://open.t.qq.com/cgi-bin/access_token"];
}

- (NSURL*) getAuthorizeUrl:(OAuthKey*)token {
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://open.t.qq.com/cgi-bin/authorize?oauth_token=%@", token.tokenKey]]; 
}

@end
