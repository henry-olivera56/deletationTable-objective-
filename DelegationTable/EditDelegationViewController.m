//
//  EditDelegationViewController.m
//  
//
//  Created by DODOBAL-1 on 11/16/15.
//
//

#import "EditDelegationViewController.h"

@interface EditDelegationViewController ()

@end

@implementation EditDelegationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title=@"Edit Delegation";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"mm/dd/yyyy"];
    
    self.delegationnameTextField.text=_delegation.name;
    self.arrivalTextField.text = [formatter stringFromDate:_delegation.arrivaldate];
    
    self.backTextField.text=[formatter stringFromDate:_delegation.backdate];
    NSLog(@"%@  %@",self.arrivalTextField.text,self.backTextField.text);
    self.memberCountLabel.text=[NSString stringWithFormat:@"%d",_delegation.members.count];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
}

-(void)done
{
    _delegation.name=self.delegationnameTextField.text;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm/dd/yyyy"];
    
    _delegation.arrivaldate = [dateFormatter dateFromString:self.arrivalTextField.text];
    _delegation.backdate=[dateFormatter dateFromString:self.backTextField.text];

    _completionDelegationHandler(self,NO);
}

-(void)cancel
{
    _completionDelegationHandler(self,YES);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+(void)editDelegation:(Delegation *)delegation inNavigationController:(UINavigationController *)navigationController completion:(EditDelegationViewControllerCompletionHandler)completionDelegationHandler
{
    EditDelegationViewController *editDelegationViewController=[[EditDelegationViewController alloc] initWithDelegation:delegation completion:completionDelegationHandler];
    [navigationController pushViewController:editDelegationViewController animated:YES];
}

-(id)initWithDelegation:(Delegation *)delegation completion:(EditDelegationViewControllerCompletionHandler)completionDelegationHandler
{
    self=[super initWithNibName:nil bundle:nil];
    if(self)
    {
        _completionDelegationHandler=completionDelegationHandler;
        _delegation=delegation;
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
