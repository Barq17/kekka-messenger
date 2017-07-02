//
//  AppDelegate.m
//  MessengerApp
//
//  Created by Vlad on 09.06.17.
//  Copyright © 2017 Bark. All rights reserved.
//

#import "AppDelegate.h"
#import "UIColor+AppColors.h"

#import "AuthSession.h"
#import "User.h"

@import Firebase;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FIRApp configure];
    [self configureUIAppearance];
    [self prepareForViewController];
    return YES;
}

- (void)prepareForViewController {
    if (AuthSession.currentSession.isValid) {
        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *mainRootVC = [mainSB instantiateInitialViewController];
        self.window.rootViewController = mainRootVC;
    } else {
        UIStoryboard *loginSB = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        UIViewController *loginRootVC = [loginSB instantiateInitialViewController];
        self.window.rootViewController = loginRootVC;
    }
}

- (void)configureUIAppearance {
    [UINavigationBar.appearance setBarTintColor:[UIColor navBarColor]];
    [UINavigationBar.appearance setBarStyle:UIBarStyleBlackOpaque];
    [UINavigationBar.appearance setTintColor:[UIColor navBarItemColor]];
    [UITabBar.appearance setBarTintColor:[UIColor navBarColor]];
    [UITabBar.appearance setTintColor:[UIColor navBarItemColor]];
    [UISearchBar.appearance setSearchBarStyle:UISearchBarStyleProminent];
    [UISearchBar.appearance setTintColor:[UIColor colorWithRed: 59.0/255.0 green: 59.0/255.0 blue: 59.0/255.0 alpha: 1.0]];
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"MessengerApp"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end