//
//  ViewController.h
//  sso
//
//  Created by Jimbas on 12/21/17.
//  Copyright © 2017 MNC. All rights reserved.
//

#import <UIKit/UIKit.h>

@import SafariServices;

@interface ViewController : UIViewController <SFSafariViewControllerDelegate>

- (void)loginCallback:(NSDictionary*)dict;

@end

