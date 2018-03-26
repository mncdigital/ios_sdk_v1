//
//  ViewController.m
//  sso
//
//  Created by Jimbas on 12/21/17.
//  Copyright © 2017 MNC. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *mUuid;
@property (weak, nonatomic) IBOutlet UILabel *mUsername;
@property (weak, nonatomic) IBOutlet UILabel *mStatus;
@property (weak, nonatomic) IBOutlet UILabel *mToken;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)loginCallback:(NSDictionary*)dict {
	NSLog(@"uuid: %@", [dict objectForKey:@"uuid"]);
	NSLog(@"username: %@", [dict objectForKey:@"username"]);
	NSLog(@"status: %@", [dict objectForKey:@"status"]);
	NSLog(@"token: %@", [dict objectForKey:@"token"]);
	NSString *uuid = [NSString stringWithFormat:@"uuid: %@", [dict objectForKey:@"uuid"]];
	NSString *username = [NSString stringWithFormat:@"username: %@", [dict objectForKey:@"username"]];
	NSString *status = [NSString stringWithFormat:@"status: %@", [dict objectForKey:@"status"]];
	NSString *token = [NSString stringWithFormat:@"token: %@", [dict objectForKey:@"token"]];
	self.mUuid.text = [uuid stringByRemovingPercentEncoding];
	self.mUsername.text = [username stringByRemovingPercentEncoding];
	self.mStatus.text = [status stringByRemovingPercentEncoding];
	self.mToken.text = [token stringByRemovingPercentEncoding];
}

- (void)viewDidAppear:(BOOL)animated {
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)loadBrowser:(NSString*)mode {
	NSString *ck = [NSString stringWithFormat:@"QiGJIvlP9noC4fhx"];
	NSString *r = [NSString stringWithFormat:@"com.mncdig.example"];
	NSString *pf = [NSString stringWithFormat:@"ios"];
	
	NSString *surl = [NSString stringWithFormat:@"https://account.mncdigital.id/%@?ck=%@&r=%@&pf=%@", mode, ck, r, pf];
	NSURL *URL = [NSURL URLWithString:surl];
	UIApplication *application = [UIApplication sharedApplication];
	[application openURL:URL options:@{} completionHandler:nil];
}

- (IBAction)actionLogin:(id)sender {
	((AppDelegate*)[[UIApplication sharedApplication] delegate]).loginViewCtrl = self;
	[self loadBrowser:[NSString stringWithFormat:@"login"]];
}
- (IBAction)actionProfile:(id)sender {
	((AppDelegate*)[[UIApplication sharedApplication] delegate]).loginViewCtrl = self;
	[self loadBrowser:[NSString stringWithFormat:@"profile"]];
}
- (IBAction)actionLogout:(id)sender {
	((AppDelegate*)[[UIApplication sharedApplication] delegate]).loginViewCtrl = self;
	[self loadBrowser:[NSString stringWithFormat:@"logout"]];
}


@end
