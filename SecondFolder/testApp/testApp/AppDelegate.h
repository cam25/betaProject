//
//  AppDelegate.h
//  testApp
//
//  Created by Cameron Mozie on 8/8/13.
//  Copyright (c) 2013 Cameron Mozie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
{
    UIWindow *window;
    UITabBarController *tabController;
}

@property (nonatomic,retain) IBOutlet UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

//@property (nonatomic, retain) UITabBarController * tabBarController;


@property (nonatomic,retain)  IBOutlet UITabBarController *tabController;

@end
