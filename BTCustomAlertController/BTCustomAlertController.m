//
//  BTCustomAlertController.m
//  BTCustomAlertController
//
//  Created by Rechael on 2017/12/6.
//  Copyright © 2017年 Flyada. All rights reserved.
//

#import "BTCustomAlertController.h"

@implementation BTAction

- (id)initWithTitle:(NSString *)title action:(dispatch_block_t)action {
    self = [super init];
    if (self) {
        _title = title;
        _action = action;
    }
    return self;
}

+ (BTAction *)actionWithTitle:(NSString *)title action:(dispatch_block_t)action {
    BTAction *ac = [[BTAction alloc] initWithTitle:title action:action];
    return ac;
}

@end



@interface BTCustomAlertController ()

@end

CGFloat backViewH = 197.5;

@implementation BTCustomAlertController{
    NSString            *_title;
    NSString            *_message;
    
    UIView              *_backView;
    
    UILabel             *_titleLbl;
    UILabel             *_messageLbl;
    
    UIButton            *_cancel;
    UIButton            *_send;
    
    UIView              *_hLine;
    UIView              *_vLine;
    
    CGFloat             _backBottom;
    NSLayoutConstraint  *_bottom;
    
    NSMutableArray      *_actions;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message {
    self = [super init];
    if (self) {
        _title = title;
        _message = message;
        _actions = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.35];
    
    _backBottom = -(CGRectGetHeight(self.view.frame) - backViewH) / 2.;
    
    _backView = [[UIView alloc] initWithFrame:CGRectZero];
    _backView.translatesAutoresizingMaskIntoConstraints = false;
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.cornerRadius = 5;
    _backView.layer.masksToBounds = true;
    [self.view addSubview:_backView];
    
    _titleLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLbl.translatesAutoresizingMaskIntoConstraints = false;
    _titleLbl.textColor = [UIColor colorWithHex:0x333333];
    _titleLbl.font = [UIFont boldSystemFontOfSize:18];
    _titleLbl.text = _title;
    [_titleLbl setTextAlignment:NSTextAlignmentCenter];
    [_backView addSubview:_titleLbl];
    
    
    _messageLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    _messageLbl.translatesAutoresizingMaskIntoConstraints = false;
    _messageLbl.textColor = [UIColor colorWithHex:0x666666];
    _messageLbl.font = [UIFont systemFontOfSize:14];
    _messageLbl.text = _message;
    _messageLbl.numberOfLines = 0;
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:_message];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:5];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [_message length])];
    [_messageLbl setAttributedText:attributedString1];
    [_backView addSubview:_messageLbl];
    
    
    UIColor *lineColor = [UIColor colorWithHex:0xdddddd];
    
    _hLine = [[UIView alloc] initWithFrame:CGRectZero];
    _hLine.translatesAutoresizingMaskIntoConstraints = false;
    _hLine.backgroundColor = lineColor;
    [_backView addSubview:_hLine];
    
    _vLine = [[UIView alloc] initWithFrame:CGRectZero];
    _vLine.translatesAutoresizingMaskIntoConstraints = false;
    _vLine.backgroundColor = lineColor;
    [_backView addSubview:_vLine];
    
    _cancel = [UIButton buttonWithType:UIButtonTypeSystem];
    _cancel.translatesAutoresizingMaskIntoConstraints = false;
    
    if (self.isShowCancel) {
        NSString *cancel = [(BTAction *)_actions[0] title];
        [_cancel setTitle:cancel forState:UIControlStateNormal];
        [_cancel setTitleColor:[UIColor colorWithHex:0x3775da] forState:UIControlStateNormal];
        _cancel.titleLabel.font = [UIFont systemFontOfSize:14];
        [_cancel addTarget:self action:@selector(shbClickedBtn:) forControlEvents:UIControlEventTouchUpInside];
        _cancel.tag = 100;
        [_backView addSubview:_cancel];
        
        _send = [UIButton buttonWithType:UIButtonTypeSystem];
        _send.translatesAutoresizingMaskIntoConstraints = false;
        NSString *send = [(BTAction *)_actions[1] title];
        [_send setTitle:send forState:UIControlStateNormal];
        [_send setTitleColor:[UIColor colorWithHex:0xda3737] forState:UIControlStateNormal];
        _send.titleLabel.font = [UIFont systemFontOfSize:14];
        [_send addTarget:self action:@selector(shbClickedBtn:) forControlEvents:UIControlEventTouchUpInside];
        _send.tag = 200;
        [_backView addSubview:_send];
    }else{
        _send = [UIButton buttonWithType:UIButtonTypeSystem];
        _send.translatesAutoresizingMaskIntoConstraints = false;
        NSString *send = [(BTAction *)_actions[0] title];
        [_send setTitle:send forState:UIControlStateNormal];
        [_send setTitleColor:[UIColor colorWithHex:0xda3737] forState:UIControlStateNormal];
        _send.titleLabel.font = [UIFont systemFontOfSize:14];
        [_send addTarget:self action:@selector(shbClickedBtn:) forControlEvents:UIControlEventTouchUpInside];
        _send.tag = 200;
        [_backView addSubview:_send];
    }
    
    
    if (self.isShowCancel) {
        NSDictionary *views = NSDictionaryOfVariableBindings(_backView, _titleLbl, _messageLbl, _hLine, _vLine, _cancel, _send);
        NSDictionary *met = @{@"one" : @(1 / [UIScreen mainScreen].scale)};
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-30-[_backView]-30-|" options:0 metrics:nil views:views]];
        _bottom = [NSLayoutConstraint constraintWithItem:_backView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:_backBottom];
        [self.view addConstraint:_bottom];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-30-[_backView]-30-|" options:0 metrics:nil views:views]];
        _bottom = [NSLayoutConstraint constraintWithItem:_backView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:_backBottom];
        [self.view addConstraint:_bottom];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[_titleLbl]-20-[_messageLbl]-20-[_hLine(one)][_cancel(44)]|" options:0 metrics:met views:views]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_hLine][_send]|" options:0 metrics:nil views:views]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_hLine][_vLine]|" options:0 metrics:nil views:views]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-17-[_titleLbl]-17-|" options:0 metrics:nil views:views]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-17-[_messageLbl]-17-|" options:0 metrics:nil views:views]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_hLine]|" options:0 metrics:nil views:views]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_cancel][_vLine(one)][_send(_cancel)]|" options:0 metrics:met views:views]];
    }else{
        NSDictionary *views = NSDictionaryOfVariableBindings(_backView, _titleLbl, _messageLbl, _hLine, _send);
        NSDictionary *met = @{@"one" : @(1 / [UIScreen mainScreen].scale)};
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-30-[_backView]-30-|" options:0 metrics:nil views:views]];
        _bottom = [NSLayoutConstraint constraintWithItem:_backView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:_backBottom];
        [self.view addConstraint:_bottom];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-30-[_backView]-30-|" options:0 metrics:nil views:views]];
        _bottom = [NSLayoutConstraint constraintWithItem:_backView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:_backBottom];
        [self.view addConstraint:_bottom];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[_titleLbl]-20-[_messageLbl]-20-[_hLine(one)][_send(44)]|" options:0 metrics:met views:views]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_hLine][_send]|" options:0 metrics:nil views:views]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-17-[_titleLbl]-17-|" options:0 metrics:nil views:views]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-17-[_messageLbl]-17-|" options:0 metrics:nil views:views]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_hLine]|" options:0 metrics:nil views:views]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_send]|" options:0 metrics:met views:views]];
    }
    
    self.view.layer.shouldRasterize = true;
    self.view.layer.shouldRasterize = true;
    self.view.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    [self registerKeyBoard];
}



- (void)keyBoardShow:(NSNotification *)info {
    
    NSValue *keyBoardRect = [[info userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyRect = [keyBoardRect CGRectValue];
    
    if (_backBottom > -keyRect.size.height) {
        _bottom.constant = -30 - keyRect.size.height;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyBoardHidden:(NSNotification *)info {
    _bottom.constant = _backBottom;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}


- (void)shbClickedBtn:(UIButton *)btn {
    if (self.isShowCancel) {
        if (btn.tag == 100) {
            BTAction *action = _actions[0];
            if (action.action) {
                action.action();
            }
        } else {
            BTAction *action = _actions[1];
            if (action.action) {
                action.action();
            }
        }
    }else{
        BTAction *action = _actions[0];
        if (action.action) {
            action.action();
        }
    }
    
    [self dismiss];
}

- (void)addAction:(BTAction *)action {
    [_actions addObject:action];
}


- (void)show {
    UIViewController *result = [self currentController];
    [result addChildViewController:self];
    [result.view addSubview:self.view];
}

- (void)dismiss {
    __weak typeof(self) SHB = self;
    [UIView animateWithDuration:0.1 animations:^{
        [SHB.view removeFromSuperview];
        [SHB removeFromParentViewController];
    } completion:^(BOOL finished) {
        [SHB removeKeyBoard];
    }];
}

- (UIViewController *)currentController {
    UIViewController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        
        for (UIWindow *temWin in windows) {
            if (temWin.windowLevel == UIWindowLevelNormal) {
                window = temWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nestResponder = [frontView nextResponder];
    if ([nestResponder isKindOfClass:[UIViewController class]]) {
        result = nestResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}

#pragma mark - Keyboard
- (void)registerKeyBoard {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardHidden:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)removeKeyBoard {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
