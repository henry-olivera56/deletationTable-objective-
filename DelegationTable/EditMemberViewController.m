//
//  EditMemberViewController.m
//  
//
//  Created by DODOBAL-1 on 11/16/15.
//
//

#import "EditMemberViewController.h"

@interface EditMemberViewController ()

@end

@implementation EditMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"Edit Member";
    
    self.nameTextField.text=_member.name;
    
    //self.sexTextField.text=(!(_member.sex) && (_member.sex==0))?@"Male":@"Female";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"mm/dd/yyyy"];
    
    self.birthdayTextField.text = [formatter stringFromDate:_member.birthday];

   // self.birthdayTextField.text=_member.birthday;
    self.jobTextField.text=_member.job;
    self.organizationTextField.text=_member.org;
    self.schoolTextField.text=_member.school;
    self.universityTextField.text=_member.university;
    self.fathernameTextField.text=_member.fathername;
    self.fatherjobTextField.text=_member.fatherjob;
    self.motherjobTextField.text=_member.motherjob;
    self.mothernameTextField.text=_member.mothername;
    //NSString *imageFile=[[NSBundle mainBundle] pathForResource:_member.name ofType:@"jpg"];
    //UIImage *image=[UIImage imageNamed:imageFile];
    UIImage *jpeg=[UIImage imageWithData:_member.image];
    self.faceImageView.image=jpeg;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
}

-(void)done
{
    if ([self.nameTextField.text isEqual:@""])
    {
        _completionHandler(self,YES);
    }
    else{
        _member.name=self.nameTextField.text;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"mm/dd/yyyy"];
        _member.birthday = [dateFormatter dateFromString:self.birthdayTextField.text];

   /*if ([self.sexTextField.text isEqualToString:@"Male"])
   {
       _member.sex=0;
   }
    else if ([self.sexTextField.text isEqualToString:@"Female"])
    {
        _member.sex=FALSE;
    }
    */
       //_member.birthday=self.birthdayTextField.text;
        _member.job=self.jobTextField.text;
        _member.org=self.organizationTextField.text;
        _member.school=self.schoolTextField.text;
        _member.university=self.universityTextField.text;
        _member.fathername=self.fathernameTextField.text;
        _member.fatherjob=self.fatherjobTextField.text;
        _member.mothername=self.mothernameTextField.text;
        _member.motherjob=self.motherjobTextField.text;
        //_member.image=self.imageData;
        //NSLog(@"%@",self.imageData);
        _completionHandler(self,NO);
    }
    
}

-(void)cancel
{
    _completionHandler(self, YES);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(void)editMember:(Member *)member inNavigationController:(UINavigationController *)navigationController completion:(EditMemberViewControllerCompletionHandler)completionHandler
{
    EditMemberViewController *editViewController=[[EditMemberViewController alloc] initWithMember:member completion:completionHandler];
    [navigationController pushViewController:editViewController animated:YES];
}

- (IBAction)btnTakePicture:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
				picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
				picker.delegate = self;
				[self presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image=[info valueForKey:@"UIImagePickerControllerOriginalImage"];
    self.faceImageView.image=image;
    //UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    self.imageData=UIImageJPEGRepresentation(image, 1);
    _member.image=self.imageData;
    //UIGraphicsEndImageContext();
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
-(id)initWithMember:(Member *)member completion:(EditMemberViewControllerCompletionHandler)completionHandler
{
    self=[super initWithNibName:nil bundle:nil];
    if (self)
    {
        _completionHandler=completionHandler;
        _member=member;
    }
    return self;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
