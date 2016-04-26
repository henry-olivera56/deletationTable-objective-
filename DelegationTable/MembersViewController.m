//
//  MembersViewController.m
//  
//
//  Created by DODOBAL-1 on 11/16/15.
//
//

#import "MembersViewController.h"

@interface MembersViewController ()

@end

@implementation MembersViewController

-(id)initWithDelegation:(Delegation *)delegation
{
    self=[super initWithStyle:UITableViewStylePlain];
    if(self)
    {
        self.delegation=delegation;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *addButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem=addButton;
    
    self.title=self.delegation.name;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

-(void)add
{
    NSEntityDescription *memberEntityDescription=[NSEntityDescription entityForName:@"Member" inManagedObjectContext:self.delegation.managedObjectContext];
    Member *newMember=(Member *)[[NSManagedObject alloc] initWithEntity:memberEntityDescription insertIntoManagedObjectContext:self.delegation.managedObjectContext];
    
    [EditMemberViewController editMember:newMember inNavigationController:self.navigationController completion:^(EditMemberViewController *sender,BOOL canceled)
     {
         if (canceled)
         {
             [self.delegation.managedObjectContext deleteObject:newMember];
         }
         else{
             [self.delegation addMembersObject:newMember];
             NSError *error;
             if (![self.delegation.managedObjectContext save:&error])
             {
                 NSLog(@"Error saving context: %@",error);
             }
             [self.tableView reloadData];
         }
         [self.navigationController popViewControllerAnimated:YES];
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return self.delegation.members.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier=@"MemberCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Member *member=[self.delegation.members.allObjects objectAtIndex:indexPath.row];
    cell.textLabel.text=member.name;
    cell.detailTextLabel.text=member.org;

    
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Member *member=[self.delegation.members.allObjects objectAtIndex:indexPath.row];
    [EditMemberViewController editMember:member inNavigationController:self.navigationController completion:^(EditMemberViewController *sender, BOOL canceled)
     {
         NSError *error;
         if (![self.delegation.managedObjectContext save:&error])
         {
             NSLog(@"Error saving context: %@", error);
         }
         
         [self.tableView reloadData];
         [self.navigationController popViewControllerAnimated:YES];
     }];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        Member *deleted=[self.delegation.members.allObjects objectAtIndex:indexPath.row];
        [self.delegation.managedObjectContext deleteObject:deleted];
        NSError *error;
        BOOL success=[self.delegation.managedObjectContext save:&error];
        if (!success)
        {
            NSLog(@"Error saving context:%@",error);
        }
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
