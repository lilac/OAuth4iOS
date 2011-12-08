//
//  OAuthWebViewController.m
//  digugif
//
//  Created by iPhone Team on 11-12-5.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "OAuthWebViewController.h"

@implementation OAuthWebViewController
@synthesize webView, url, callback, delegate, didGetCodeSelector;
@synthesize code;
bool didGetCode;

- (void)dealloc
{
    [webView release];
    [url release];
    [callback release];
}

- (id)initWithUrl:(NSURL *)inUrl callback:(NSURL *)inCallback selector:(SEL)sel
{
    self = [self initWithNibName:NSStringFromClass([OAuthWebViewController class]) bundle:nil];
    self.url = inUrl;
    self.callback = inCallback;
    self.didGetCodeSelector = sel;
    return self;
}

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
    webView.backgroundColor = [UIColor whiteColor];
    self.webView.scalesPageToFit = YES;
    self.webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.webView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [webView loadRequest:request];
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

#pragma mark -
#pragma mark UIViewController delegate methods

- (void)viewWillAppear:(BOOL)animated
{
    self.webView.delegate = self; // setup the delegate as the web view is shown
    didGetCode = false;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.webView stopLoading];   // in case the web view is still loading its content
    self.webView.delegate = nil;  // disconnect the delegate as the webview is hidden
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // starting the load, show the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // finished loading, hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if (didGetCode) {
        if (self.didGetCodeSelector != nil) {
            [self.delegate performSelector:self.didGetCodeSelector withObject:code];
        }
        else if ([self.delegate respondsToSelector:@selector(didGetCode:)]) {
            [self.delegate didGetCode:code];
        }
        else {
            NSLog(@"Error, not didGetCode callback.");
        }
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // load error, hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // report the error inside the webview
    NSString* errorString = [NSString stringWithFormat:
                             @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>",
                             error.localizedDescription];
    [self.webView loadHTMLString:errorString baseURL:nil];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestString = [request.URL absoluteString];
    if ([requestString hasPrefix:[callback absoluteString]])
    {
        NSRange r=[requestString rangeOfString:@"oauth_verifier="];
        
        if(r.length>0)
        {
            code =[requestString substringFromIndex:r.length+r.location];
            NSLog(@"Get code: %@", code);
            didGetCode = true;
            return NO;
        }
        else {
            NSLog(@"Failed to get code.");
            return NO;
        }
    }
    else
    {
        return YES;
    }
}

@end
