//
//  AppDelegate.m
//  sso
//
//  Created by Jimbas on 12/21/17.
//  Copyright © 2017 MNC. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(NSDictionary *)queryDictionary:(NSURL*)url {
	NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
	for (NSString *param in [[url query] componentsSeparatedByString:@"&"]) {
		NSArray *parts = [param componentsSeparatedByString:@"="];
		if([parts count] < 2) continue;
		[params setObject:[parts objectAtIndex:1] forKey:[parts objectAtIndex:0]];
	}
	return params;
}

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler{
	if([userActivity.activityType isEqualToString: NSUserActivityTypeBrowsingWeb]) {
		NSURL *url = userActivity.webpageURL;
		NSDictionary* dict = [self queryDictionary:url];
		if(self.loginViewCtrl != nil) {
			ViewController *mainCtrl = (ViewController*) self.loginViewCtrl;
			[mainCtrl loginCallback:dict];
		}
	}
	return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.loginViewCtrl = nil;
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}
- (void)applicationDidEnterBackground:(UIApplication *)application {}
- (void)applicationWillEnterForeground:(UIApplication *)application {}
- (void)applicationDidBecomeActive:(UIApplication *)application {}
- (void)applicationWillTerminate:(UIApplication *)application {}


@end
