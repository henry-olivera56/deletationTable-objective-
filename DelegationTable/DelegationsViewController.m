//
//  DelegationsViewController.m
//  
//
//  Created by DODOBAL-1 on 11/16/15.
//
//

#import "DelegationsViewController.h"

@interface DelegationsViewController ()

@end

@implementation DelegationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title=@"Delegations";
    
    UIBarButtonItem *addButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem=addButton;
    
    [self fetchDelegations];
    
    
    if (self.fetchedResultsController.fetchedObjects.count==0)
    {
        NSEntityDescription *delegationEntityDescription=[NSEntityDescription entityForName:@"Delegation" inManagedObjectContext:self.managedObjectContext];
        Delegation *namphoDelegation=(Delegation *)[[NSManagedObject alloc] initWithEntity:delegationEntityDescription insertIntoManagedObjectContext:self.managedObjectContext];
        namphoDelegation.name=@"NamPho";
        NSError *error;
        if (![self.managedObjectContext save:&error])
        {
            NSLog(@"Error saving context: %@",error);
        }
        [self fetchDelegations];
    }
    
    [self fetchBirthday];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self fetchDelegations];
    [self.tableView reloadData];
}
-(void) add
{
    UIAlertView *inputAlert=[[UIAlertView alloc] initWithTitle:@"New Delegation" message:@"Enter a name for the new delegation" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    inputAlert.alertViewStyle=UIAlertViewStylePlainTextInput;
    [inputAlert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        if ([[alertView textFieldAtIndex:0].text isEqual:@""])
        {
            
        }
        else{
            NSEntityDescription *delegationEntityDescription=[NSEntityDescription entityForName:@"Delegation" inManagedObjectContext:self.managedObjectContext];
            Delegation *newDelegation=(Delegation *)[[NSManagedObject alloc] initWithEntity:delegationEntityDescription insertIntoManagedObjectContext:self.managedObjectContext];
        
            newDelegation.name=[alertView textFieldAtIndex:0].text;
            
            NSError *error;
            if (![self.managedObjectContext save:&error])
            {
                NSLog(@"Error saving context: %@",error);
            }
        }
        [self fetchDelegations];
        [self.tableView reloadData];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)initWithManagedObjectContext:(NSManagedObjectContext *)context
{
    self=[super initWithStyle:UITableViewStylePlain];
    if(self)
    {
        self.managedObjectContext=context;
    }
    return self;
}


-(id)initWithDelegation:(Delegation *)delegation
{
    self=[super initWithStyle:UITableViewStylePlain];
    if(self)
    {
        self.delegation=delegation;
    }
    return self;
}


-(void)fetchBirthday
{
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
 
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Member" inManagedObjectContext:self.managedObjectContext];

    [request setEntity:entity];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptions = [[NSArray alloc]initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];
    NSError *error = nil;

    NSMutableArray *mutableFetchResult = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResult == nil) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }
    self.dataArray = mutableFetchResult;
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSDateComponents* now = [calendar components:(NSYearCalendarUnit|NSDayCalendarUnit|NSMonthCalendarUnit) fromDate:[NSDate date]];
    NSString *nowDate = [NSString stringWithFormat:@"%02d/%02d", now.month, now.day];
    NSLog(@"%@",nowDate);
    for (Member *member in self.dataArray) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"mm/dd"];
        
        NSString *birth = [formatter stringFromDate:member.birthday];
        
        if ([birth isEqualToString:nowDate]==1)
        {
          
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Congratulations Birthday" message:member.name delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
}
-(void)fetchDelegations
{
    NSFetchRequest *fetchRequest=[NSFetchRequest fetchRequestWithEntityName:@"Delegation"];
    NSString *cacheName=[@"Delegation" stringByAppendingString:@"Cache"];
    
    NSSortDescriptor *sortDescriptor=[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    self.fetchedResultsController=[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:cacheName];
    NSError *error;
    if(![self.fetchedResultsController performFetch:&error])
    {
        NSLog(@"Fetch failed: %@",error);
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.fetchedResultsController.fetchedObjects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier=@"DelegationCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    }
    
    Delegation *delegation=(Delegation *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text=delegation.name;
    cell.detailTextLabel.text=[NSString stringWithFormat:@"(%d)",delegation.members.count];
    return cell;
}

-(void)onSelect:(id)sender
{
    //NSLog(@"%d",sender.index);
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    Delegation *newdelegation=(Delegation *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    NSEntityDescription *delegationEntityDescription=[NSEntityDescription entityForName:@"Delegation" inManagedObjectContext:self.managedObjectContext];
    //Delegation *newDelegation=(Delegation *)[[NSManagedObject alloc] initWithEntity:delegationEntityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    [EditDelegationViewController editDelegation:newdelegation inNavigationController:self.navigationController completion:^(EditDelegationViewController *sender, BOOL canceled)
     {
         if (canceled)
         {
             //[self.managedObjectContext deleteObject:newdelegation];
         }
         else{
            
             NSError *error;
             if (![self.managedObjectContext save:&error])
             {
                 NSLog(@"Error saving context: %@",error);
             }
             [self.tableView reloadData];
         }
         [self.navigationController popViewControllerAnimated:YES];

         //[self fetchDelegations];
        // [self.tableView reloadData];
        // [self.navigationController popViewControllerAnimated:YES];
     }];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source

        
        NSManagedObject *deleted=[self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.managedObjectContext deleteObject:deleted];
    
        NSError *error;
        BOOL success=[self.managedObjectContext save:&error];
        if (!success)
        {
            NSLog(@"Error saving contxt: %@",error);
        }
        [self fetchDelegations];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Delegation *delegation=(Delegation *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    MembersViewController *detailViewController=[[MembersViewController alloc] initWithDelegation:delegation];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
