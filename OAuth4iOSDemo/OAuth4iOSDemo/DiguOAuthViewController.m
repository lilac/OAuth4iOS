//
//  DiguOAuthViewController.m
//  OAuth4iOSDemo
//
//  Created by iPhone Team on 11-12-7.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "DiguOAuthViewController.h"
#import "OAuthWebViewController.h"
#import "OAuth10aSina.h"
#import "OAuthSyncApi.h"
#import "OAuthKey.h"
#import "NSURL+Additions.h"

@implementation DiguOAuthViewController

@synthesize oauthQQ = oauthQQ_;
@synthesize api = api_;
@synthesize qqRequestToken = qqRequestToken_;
@synthesize qqAccessToken = qqAccessToken_;

NSString *const qqKey = @"801072306";
NSString *const qqSecret = @"45ae8d70b4146452ce4028fdf57d7e77";
NSString *const callback = @"http://gif.digu.com/oauth";

NSString *const sinaKey = @"2244869331";
NSString *const sinaSecret = @"b7717ece4c110a3bf0de754b2d3513e7";

OAuthToken *sinaRequestToken;
OAuthToken *sinaAccessToken;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)didGetQQCode:(NSString *)code {
    
    //NSString *code = (NSString*) codeObj;
    self.qqAccessToken = [self.api getAccessTokenWithConsumerKey:qqKey consumerSecret:qqSecret requestTokenKey:self.qqRequestToken.key requestTokenSecret:self.qqRequestToken.secret verify:code];
    [self.navigationController dismissModalViewControllerAnimated:YES];
    NSString *msg = [NSString stringWithFormat:@"%key:%@;secret:%@", self.qqAccessToken.key, self.qqAccessToken.secret];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QQ Access Token" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (IBAction)qqBtnClicked:(id)sender {
    
    self.oauthQQ = [[OAuth10aQQ alloc] init];
    self.api = [[OAuthSyncApi alloc] initWithProvider:self.oauthQQ];
    [self.oauthQQ release];
    self.qqRequestToken = [self.api getRequestTokenWithConsumerKey:qqKey consumerSecret:qqSecret callback:callback];
    
    OAuthKey *oauthKey = [[OAuthKey alloc] init];
    oauthKey.tokenKey = self.qqRequestToken.key;
    NSURL *url = [self.oauthQQ getAuthorizeUrl:oauthKey];
    OAuthWebViewController *wvCtl = [[OAuthWebViewController alloc] initWithUrl:url callback:[NSURL URLWithString:callback] selector:@selector(didGetQQCode:)];
    wvCtl.delegate = self;
    wvCtl.navigationItem.title = @"登录腾讯微博";
    [self.navigationController pushViewController:wvCtl animated:YES];
    //wvCtl.navigationItem.leftBarButtonItem.title = @"Cancel";
}

- (void)didGetSinaCode:(NSString *)code {
    sinaAccessToken = [self.api getAccessTokenWithConsumerKey:sinaKey consumerSecret:sinaSecret requestTokenKey:sinaRequestToken.key requestTokenSecret:sinaRequestToken.secret verify:code];
    [sinaAccessToken retain];
    [self.navigationController popViewControllerAnimated:YES];
    NSString *msg = [NSString stringWithFormat:@"key:%@\nsecret:%@", sinaAccessToken.key, sinaAccessToken.secret];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sina Access Token" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (IBAction)sinaBtnClicked:(id)sender {
    OAuth10aSina *oauthSina = [[OAuth10aSina alloc] init];
    self.api = [[OAuthSyncApi alloc] initWithProvider:oauthSina];
    [oauthSina release];
    sinaRequestToken = [self.api getRequestTokenWithConsumerKey:sinaKey consumerSecret:sinaSecret callback:callback];
    [sinaRequestToken retain];
    OAuthKey *oauthKey = [[OAuthKey alloc] init];
    oauthKey.tokenKey = sinaRequestToken.key;
    NSURL *url = [oauthSina getAuthorizeUrl:oauthKey];
    OAuthWebViewController *wvCtl = [[OAuthWebViewController alloc] initWithUrl:url callback:[NSURL URLWithString:callback] selector:@selector(didGetSinaCode:)];
    wvCtl.delegate = self;
    wvCtl.navigationItem.title = @"登录新浪微博";
    [self.navigationController pushViewController:wvCtl animated:YES];
}
@end
