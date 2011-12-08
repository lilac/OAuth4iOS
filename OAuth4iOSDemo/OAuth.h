//
//  @Author James Deng
//
//  Last updated 2011/12/6.
//  
//

#import <Foundation/Foundation.h>


@interface OAuth : NSObject {

}

/*
 * Get the URL based on the specified key.
 * 
 * param url
 *            The full url that needs to be signed including its non OAuth
 *            url parameters
 * param httpMethod
 *            The http method used. Must be a valid HTTP method verb
 *            (POST,GET,PUT, etc)
 * param customKey
 *            The consumer key
 * param customSecrect
 *            The consumer seceret
 * param tokenKey
 *            The token, if available. If not available pass null or an
 *            empty string
 * param tokenSecrect
 *            The token secret, if available. If not available pass null or
 *            an empty string
 * param verify
 *            The oAauth Verifier.
 * param callbackUrl
 *            The OAuth Callback URL(You should encode this url if it
 *            contains some unreserved characters).
 * param parameters
 * param queryString
 * 
 */
- (NSString *)getOauthUrl:(NSString *)aUrl 
			   httpMethod:(NSString *)aMethod 
				consumerKey:(NSString *)aConsumerKey 
			 consumerSecret:(NSString *)aConsumerSecret 
				 tokenKey:(NSString *)aTokenKey 
			  tokenSecret:(NSString *)aTokenSecret 
				   verify:(NSString *)aVerify 
			  callbackUrl:(NSString *)aCallbackUrl 
			   parameters:(NSDictionary *)aParameters 
			  queryString:(NSString **)aQueryString;

@end
