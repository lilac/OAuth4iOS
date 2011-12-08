//
//  OAuthWebViewController.h
//  digugif
//
//  Created by iPhone Team on 11-12-5.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OAuthWebViewDelegate; 

@interface OAuthWebViewController : UIViewController<UIWebViewDelegate>
{
}
@property (nonatomic, retain) NSString *code;

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) NSURL *url;
@property (nonatomic, retain) NSURL *callback;
@property (nonatomic, retain) id<OAuthWebViewDelegate> delegate;
@property (assign) SEL didGetCodeSelector;

- (id)initWithUrl:(NSURL *)inUrl callback:(NSURL *)inCallback selector:(SEL)sel;
@end

@protocol OAuthWebViewDelegate <NSObject>
@optional
-(void)didGetCode:(NSString *)code;

@end
