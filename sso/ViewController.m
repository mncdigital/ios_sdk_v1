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

@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnProfile;
@property (weak, nonatomic) IBOutlet UIButton *btnLogout;

@property(nonatomic,strong)SFSafariViewController *safariVC;
@property(nonatomic,strong)NSString *sMode;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.sMode = [NSString stringWithFormat:@"logout"];
	[self decideEnableDisableBtn];
}

- (void)viewDidAppear:(BOOL)animated {}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void) decideEnableDisableBtn {
	if([self.sMode isEqualToString:@"register"]) {
		self.btnRegister.enabled = self.btnLogin.enabled = YES;
		self.btnProfile.enabled = self.btnLogout.enabled = NO;
	} else if([self.sMode isEqualToString:@"login"]) {
		self.btnRegister.enabled = self.btnLogin.enabled = NO;
		self.btnProfile.enabled = self.btnLogout.enabled = YES;
	} else if([self.sMode isEqualToString:@"profile"]) {
		self.btnRegister.enabled = self.btnLogin.enabled = NO;
		self.btnProfile.enabled = self.btnLogout.enabled = YES;
	} else if([self.sMode isEqualToString:@"logout"]) {
		self.btnRegister.enabled = self.btnLogin.enabled = YES;
		self.btnProfile.enabled = self.btnLogout.enabled = NO;
	}
}

- (void)loginCallback:(NSDictionary*)dict {
	[self.safariVC dismissViewControllerAnimated:YES completion:nil];
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
	self.sMode = [NSString stringWithFormat:[dict objectForKey:@"status"]];
	[self decideEnableDisableBtn];
}

- (IBAction)actionLogin:(id)sender {
	((AppDelegate*)[[UIApplication sharedApplication] delegate]).loginViewCtrl = self;
	[self openSafariVc:@"login"];
}
- (IBAction)actionRegister:(id)sender {
	((AppDelegate*)[[UIApplication sharedApplication] delegate]).loginViewCtrl = self;
	[self openSafariVc:@"register"];
}
- (IBAction)actionProfile:(id)sender {
	((AppDelegate*)[[UIApplication sharedApplication] delegate]).loginViewCtrl = self;
	[self openSafariVc:@"profile"];
}
- (IBAction)actionLogout:(id)sender {
	((AppDelegate*)[[UIApplication sharedApplication] delegate]).loginViewCtrl = self;
	[self openSafariVc:@"logout"];
}

// Notes:
// • Flipping directly to mobile safari potentially be rejected by apple's AppReviewBoard
// • iOS 11 no longer providing shared cookies between Mobile Safari, SFSafariViewController instances

//- (void)openMobileSafari:(NSString*)mode {
//	NSURL *URL = [NSURL URLWithString:surl];
//	UIApplication *application = [UIApplication sharedApplication];
//	[application openURL:URL options:@{} completionHandler:nil];
//}

- (void) openSafariVc:(NSString*)mode {
	NSString *ck = [NSString stringWithFormat:@"QiGJIvlP9noC4fhx"];
	NSString *r = [[NSBundle mainBundle] bundleIdentifier];
	NSString *pf = [NSString stringWithFormat:@"ios"];
	NSString *surl = [NSString stringWithFormat:@"https://dev.mncdigital.info/%@?ck=%@&r=%@&pf=%@", mode, ck, r, pf];
	self.safariVC = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:surl] entersReaderIfAvailable:NO];
	self.safariVC.delegate = self;
	[self presentViewController:self.safariVC animated:YES completion:nil];
}

#pragma mark - SFSafariViewController delegate methods
-(void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully {
	NSLog(@"Load finished");
}

-(void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
	NSLog(@"Done button pressed");
}

@end
