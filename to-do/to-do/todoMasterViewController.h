//
//  todoMasterViewController.h
//  to-do
//
//  Created by CURTIS STOCHL on 1/31/13.
//  Copyright (c) 2013 CURTIS STOCHL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "todoTask.h"

@interface todoMasterViewController : UITableViewController

- (IBAction)done:(UIStoryboardSegue *)sender;
- (IBAction)cancel:(UIStoryboardSegue *)sender;
- (IBAction)buttonEditClick:(UIBarButtonItem *)sender;
- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath;

//@property (copy, nonatomic) NSMutableAttributedString *taskName;
@end
