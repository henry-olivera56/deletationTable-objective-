//
//  DelegationsViewController.h
//  
//
//  Created by DODOBAL-1 on 11/16/15.
//
//

#import <UIKit/UIKit.h>
#import "Delegation.h"
#import "MembersViewController.h"
#import "EditDelegationViewController.h"

@interface DelegationsViewController : UITableViewController<UIAlertViewDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSMutableArray *dataArray;   //BirthdayAlarm
@property (strong, nonatomic) Delegation *delegation;
-(id) initWithManagedObjectContext:(NSManagedObjectContext *)context;
-(id)initWithDelegation:(Delegation *)delegation;
@end
