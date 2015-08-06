//
//  ViewController.h
//  SongKick
//
//  Created by Robin Mukanganise on 2015/07/21.
//  Copyright (c) 2015 Seech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputField;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


- (IBAction)didPressSearch:(id)sender;

@end

