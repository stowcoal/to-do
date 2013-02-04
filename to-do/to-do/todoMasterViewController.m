//
//  todoMasterViewController.m
//  to-do
//
//  Created by CURTIS STOCHL on 1/31/13.
//  Copyright (c) 2013 CURTIS STOCHL. All rights reserved.
//

#import "todoMasterViewController.h"
#import "todoDetailViewController.h"
#import "todoAddViewController.h"

@interface todoMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation todoMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
 /*
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
  */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
*/
#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = _objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

- (IBAction)done:(UIStoryboardSegue *)segue;
{
    if ([[segue identifier] isEqualToString:@"DoneAdd"] ||
        [[segue identifier] isEqualToString:@"DoneKeyboard"]) {
        todoAddViewController *addController = [segue sourceViewController];
        if (![addController.textFieldTask.text isEqualToString:@""]) {
            if (!_objects) {
                _objects = [[NSMutableArray alloc] init];
            }
            //addController.textFieldTask.textColor;
            
            _taskName = [[NSMutableAttributedString alloc] initWithString:addController.textFieldTask.text];
            /*
            [_taskName addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, _taskName.length)];
             */
            [_objects insertObject:_taskName atIndex:_objects.count];
            //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            //[self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [[self tableView] reloadData];
            //[[self tableView] indexPathForSelectedRow];
            addController.textFieldTask.text = @"";
        }
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [[cell textLabel] setAttributedText:[_objects objectAtIndex:[indexPath row]]];
}
- (IBAction)cancel:(UIStoryboardSegue *)segue;
{
    if([[segue identifier] isEqualToString:@"CancelAdd"]) {
        todoAddViewController *addController = [segue sourceViewController];
        addController.textFieldTask.text = @"";
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (IBAction)buttonEditClick:(UIBarButtonItem *)sender {
    if (self.tableView.editing)
        [[self tableView] setEditing:NO animated:YES];
    else
        [[self tableView] setEditing:YES animated:YES];
}
- (void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath
{
    if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark)
    {
        [[_objects objectAtIndex:[indexPath row]] addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [[_objects objectAtIndex:[indexPath row]] length])];
        [[_objects objectAtIndex:[indexPath row]] addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleNone] range:NSMakeRange(0, [[_objects objectAtIndex:[indexPath row]] length])];
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    }
    else
    {
        [[_objects objectAtIndex:[indexPath row]] addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, [[_objects objectAtIndex:[indexPath row]] length])];
        [[_objects objectAtIndex:[indexPath row]] addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, [[_objects objectAtIndex:[indexPath row]] length])];

        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    }
    [[self tableView] reloadData];
    //[_objects setObject: atIndexedSubscript:[indexPath row]]
}
@end
