//
//  OAuthToken.h
//  OAuth4iOS
//
//  Created by iPhone Team on 11-12-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OAuthToken : NSObject {
    NSString *key;
    NSString *secret;
}

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *secret;
@end
