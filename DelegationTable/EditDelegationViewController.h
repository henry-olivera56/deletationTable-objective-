//
//  EditDelegationViewController.h
//  
//
//  Created by DODOBAL-1 on 11/16/15.
//
//

#import <UIKit/UIKit.h>
#import "Delegation.h"

@class EditDelegationViewController;

typedef void (^EditDelegationViewControllerCompletionHandler)(EditDelegationViewController *sender,BOOL canceled);
@interface EditDelegationViewController : UIViewController
{
    @private
    EditDelegationViewControllerCompletionHandler _completionDelegationHandler;
    Delegation *_delegation;
}
@property (weak, nonatomic) IBOutlet UITextField *delegationnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *arrivalTextField;
@property (weak, nonatomic) IBOutlet UITextField *backTextField;
@property (weak, nonatomic) IBOutlet UILabel *memberCountLabel;

-(id)initWithDelegation:(Delegation *)delegation completion:(EditDelegationViewControllerCompletionHandler)completionDelegationHandler;
+(void)editDelegation:(Delegation *)delegation inNavigationController:(UINavigationController *)navigationController completion:(EditDelegationViewControllerCompletionHandler)completionDelegationHandler;
@end
