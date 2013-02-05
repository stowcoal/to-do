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
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:app];
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // paths[0];
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    if ([fileManager fileExistsAtPath:plistPath] == YES)
    {
        NSMutableArray *readArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
        _objects = [[NSMutableArray alloc] init];
        NSEnumerator *enumerator = [readArray objectEnumerator];
        NSString *str = [[NSString alloc] init];
        while ( str = [enumerator nextObject])
        {
            todoTask *tempTodo = [[todoTask alloc] init];
            tempTodo.taskName = str;
            str = [enumerator nextObject];
            tempTodo.checked = str;
            [_objects addObject:tempTodo];
        }
        [[self tableView] reloadData];
    }
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
            todoTask *test = [[todoTask alloc] init];
            test.taskName = addController.textFieldTask.text;
            test.checked = @"no";
            //[_objects insertObject:[[NSMutableAttributedString alloc] initWithString:addController.textFieldTask.text] atIndex:_objects.count];
            [_objects insertObject:test atIndex:_objects.count];
            [[self tableView] reloadData];
            addController.textFieldTask.text = @"";
        }
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    todoTask *temp = [_objects objectAtIndex:[indexPath row]];
    if( [temp.checked isEqualToString:@"yes"] )
    {
        NSMutableAttributedString *tempString = [[NSMutableAttributedString alloc] initWithString:temp.taskName];
        [tempString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, [tempString length])];
        [tempString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, [tempString length])];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [[cell textLabel] setAttributedText:tempString];
    }
    else
    {
        NSMutableAttributedString *tempString = [[NSMutableAttributedString alloc] initWithString:temp.taskName];
        cell.accessoryType = UITableViewCellAccessoryNone;
        [[cell textLabel] setAttributedText:tempString];
    }
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
    todoTask *temp = [_objects objectAtIndex:[indexPath row]];
    if( temp.checked == @"yes" )
    {
        temp.checked = @"no";
        /*
         [[_objects objectAtIndex:[indexPath row]] addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [[_objects objectAtIndex:[indexPath row]] length])];
        [[_objects objectAtIndex:[indexPath row]] addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleNone] range:NSMakeRange(0, [[_objects objectAtIndex:[indexPath row]] length])];
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
         */
    }
    else
    {
        temp.checked = @"yes";
        /*
         [[_objects objectAtIndex:[indexPath row]] addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, [[_objects objectAtIndex:[indexPath row]] length])];
        [[_objects objectAtIndex:[indexPath row]] addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, [[_objects objectAtIndex:[indexPath row]] length])];

        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
         */
    }
    [[self tableView] reloadData];
    //[_objects setObject: atIndexedSubscript:[indexPath row]]
}
- (void)applicationDidEnterBackground:(NSNotification *)notification {
    NSLog(@"Entering Background");
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // paths[0];
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"data.plist"];
    //NSArray  *keys = [[NSArray alloc] initWithObjects:@"task", nil];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSEnumerator *enumerator = [_objects objectEnumerator];
    todoTask *tempTodo;
    while ( tempTodo = [enumerator nextObject])
    {
        [array addObject:tempTodo.taskName];
        [array addObject:tempTodo.checked];
    }
    [array writeToFile:plistPath atomically:YES];
}
@end
