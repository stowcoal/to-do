//
//  todoTask.h
//  to-do
//
//  Created by CURTIS STOCHL on 1/31/13.
//  Copyright (c) 2013 CURTIS STOCHL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface todoTask : NSObject
@property (nonatomic, copy) NSString *taskName;
@property (nonatomic) Boolean *complete;

@end
