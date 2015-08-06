//
//  ViewController.m
//  SongKick
//
//  Created by Robin Mukanganise on 2015/07/21.
//  Copyright (c) 2015 Seech. All rights reserved.
//

#import "MainViewController.h"
#import "ApiManager.h"


@interface MainViewController ()
{
    NSArray *songKickArtist;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(songKickArtist && [songKickArtist count] > 0)
        return 1;
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(songKickArtist)
        return [songKickArtist count];
    
    return 0;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    //static NSString * cellIdentifier = @"flickrCell";
//    
////    FlickrCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
////    
////    FlickrPhoto * fp = [songs objectAtIndex:indexPath.row];
////    
////    //Task: Show photo in cell
////    NSLog(@"Index Path %ld", (long)indexPath.row);
////    cell.label.text = fp.title;
////    //[cell.picture hnk_setImageFromURL:[NSURL URLWithString:fp.smallPhotoUrlString]];
////    cell.picture.image = [[ApiManager sharedInstance] requestImagesFromURL:fp.smallPhotoUrlString].image;
////    NSLog(@"Setting cell done");
////    
////    //[cell.picture setImageWithURL:[NSURL URLWithString:fp.smallPhotoUrlString]];
////    cell.label.textColor = fp.isFavourite ? [UIColor greenColor] : [UIColor blackColor];
////    
////    return cell;
//}

#pragma mark - Table view delegate
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //TODO: Show view with photos for a specific user
//    FlickrPhoto * fp = [songs objectAtIndex:indexPath.row];
//    NSLog(@"Photo Owner--> %@", fp.owner);
//}
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    
//    
//    if ([[segue identifier] isEqualToString:@"goToUserPhoto"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        FlickrPhoto * fp = [songs objectAtIndex:indexPath.row];
//        UserViewController *destViewController = segue.destinationViewController;
//        destViewController.userID = fp.owner;
//        
//    }
//}


#pragma mark- Textfield delegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark - IBActions
- (IBAction)didPressSearch:(id)sender {
    
    [self.inputField endEditing:YES];
    [[ApiManager sharedInstance] searchForArtist:self.inputField.text completion:
     ^(NSArray * songs) {
        if(songs)
        {
            NSLog(@"Got the string %@" , self.inputField.text);
            songKickArtist = songs;
            [self.tableView reloadData];
        }
    }];
}
@end
