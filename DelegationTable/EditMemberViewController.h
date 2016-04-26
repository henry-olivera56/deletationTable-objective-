//
//  EditMemberViewController.h
//  
//
//  Created by DODOBAL-1 on 11/16/15.
//
//

#import <UIKit/UIKit.h>
#import "Member.h"

@class EditMemberViewController;

typedef void (^EditMemberViewControllerCompletionHandler)(EditMemberViewController *sender,BOOL canceled);

@interface EditMemberViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    @private
    EditMemberViewControllerCompletionHandler _completionHandler;
    Member *_member;
}
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *sexTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;
@property (weak, nonatomic) IBOutlet UITextField *jobTextField;
@property (weak, nonatomic) IBOutlet UITextField *organizationTextField;
@property (weak, nonatomic) IBOutlet UITextField *schoolTextField;
@property (weak, nonatomic) IBOutlet UITextField *universityTextField;
@property (weak, nonatomic) IBOutlet UITextField *fathernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *fatherjobTextField;
@property (weak, nonatomic) IBOutlet UITextField *mothernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *motherjobTextField;
@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;
@property (weak,nonatomic) NSData *imageData;


- (IBAction)btnTakePicture:(id)sender;
-(id)initWithMember:(Member *)member completion:(EditMemberViewControllerCompletionHandler)completionHandler;
+(void)editMember:(Member *)member inNavigationController:(UINavigationController *)navigationController completion:(EditMemberViewControllerCompletionHandler)completionHandler;
@end
