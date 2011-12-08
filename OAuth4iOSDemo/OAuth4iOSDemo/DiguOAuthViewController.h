//
//  DiguOAuthViewController.h
//  OAuth4iOSDemo
//
//  Created by iPhone Team on 11-12-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAuth10aQQ.h"
#import "OAuthSyncApi.h"
#import "OAuthToken.h"

@interface DiguOAuthViewController : UIViewController {
    OAuth10aQQ *oauthQQ_;
    OAuthSyncApi *api_;
    
    OAuthToken *qqRequestToken_;
    OAuthToken *qqAccessToken_;
}

@property (nonatomic, retain) OAuth10aQQ *oauthQQ;
@property (nonatomic, retain) OAuthSyncApi *api;
@property (nonatomic, retain) OAuthToken *qqRequestToken;
@property (nonatomic, retain) OAuthToken *qqAccessToken;

- (IBAction)qqBtnClicked:(id)sender;
- (IBAction)sinaBtnClicked:(id)sender;
@end
