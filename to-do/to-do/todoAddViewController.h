//
//  todoAddViewController.h
//  to-do
//
//  Created by CURTIS STOCHL on 1/31/13.
//  Copyright (c) 2013 CURTIS STOCHL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface todoAddViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *textFieldTask;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonDone;

@end
