//
//  MembersViewController.h
//  
//
//  Created by DODOBAL-1 on 11/16/15.
//
//

#import <UIKit/UIKit.h>
#import "Delegation.h"
#import "Member.h"
#import "EditMemberViewController.h"
@interface MembersViewController : UITableViewController
@property (strong, nonatomic) Delegation *delegation;
-(id)initWithDelegation:(Delegation *)delegation;
@end
