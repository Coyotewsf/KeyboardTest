//
//  ViewController.m
//  keyboardTest
//
//  Created by 海玩 on 16/4/8.
//  Copyright © 2016年 haiwan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (UITapGestureRecognizer *)tapGesture {
    if (_tapGesture == nil) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)];
    }
    
    return _tapGesture;
}

- (void)tapGestureAction {
    [self.view endEditing:YES];
}

-(void) keyboardWillShow:(NSNotification *)note
{
    NSDictionary *userInfo = [note userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
//    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
//    NSTimeInterval animationDuration;
//    [animationDurationValue getValue:&animationDuration];
    
    CGFloat keyboardHeight = keyboardRect.size.height;
    CGRect frame = self.tableView.frame;
    
    CGFloat height = self.view.frame.size.height - keyboardHeight;
    
    //    frame.size.height -= keyboardHeight - lastShowKeyBoardHeight  - self.toolBar.frame.size.height;
    frame.size.height = height;
    
//    lastShowKeyBoardHeight = keyboardHeight;
    
    //[CATransaction begin];
    //[UIView animateWithDuration:0 animations:^{
        [self.tableView setFrame:frame];
    //} completion:^(BOOL finished) {
        //        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
        //        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    //}];
    //[CATransaction commit];
    
    [self.view addGestureRecognizer:self.tapGesture];
}

- (void)keyboardWillHide:(NSNotification*)notification {
   // NSDictionary *userInfo = [notification userInfo];
    //    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    //    CGRect keyboardRect = [aValue CGRectValue];
//    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
//    NSTimeInterval animationDuration;
//    [animationDurationValue getValue:&animationDuration];
    
    CGRect frame = self.tableView.frame;
    CGFloat height = self.view.bounds.size.height;
    frame.size.height = height;
//    lastShowKeyBoardHeight = 0;
    
    //[CATransaction begin];
//    [UIView animateWithDuration:0 animations:^{
        [self.tableView setFrame:frame];
//    } completion:^(BOOL finished) {
//        //        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
//        //        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//    }];
    //[CATransaction commit];
    
    [self.view removeGestureRecognizer:self.tapGesture];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UITextField *textField = [[UITextField alloc] init];
        textField.delegate = self;
        //textField.center = cell.center;
        textField.backgroundColor = [UIColor redColor];
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        textField.frame = CGRectMake((w-300)/2, 10, 300, 40);
        [cell addSubview:textField];
    }
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
