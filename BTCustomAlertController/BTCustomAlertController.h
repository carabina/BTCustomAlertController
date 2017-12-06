//
//  BTCustomAlertController.h
//  BTCustomAlertController
//
//  Created by Rechael on 2017/12/6.
//  Copyright © 2017年 Flyada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTAction : NSObject

@property (nonatomic, readonly, copy) NSString            *title;
@property (nonatomic, readonly, copy) dispatch_block_t    action;

+ (BTAction *)actionWithTitle:(NSString *)title action:(dispatch_block_t)action;
- (id)initWithTitle:(NSString *)title action:(dispatch_block_t)action;

@end

@interface BTCustomAlertController : UIViewController

@property (nonatomic, strong, readonly) NSString *content;
@property (nonatomic, assign) BOOL    isShowCancel;
- (id)initWithTitle:(NSString *)title message:(NSString *)message;

- (void)addAction:(BTAction *)action;

- (void)show;

@end
