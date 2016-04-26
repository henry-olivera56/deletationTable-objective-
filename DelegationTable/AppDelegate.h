//
//  AppDelegate.h
//  DelegationTable
//
//  Created by DODOBAL-1 on 11/15/15.
//  Copyright (c) 2015 DODOBAL-1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DelegationsViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) DelegationsViewController *delegationsViewController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

