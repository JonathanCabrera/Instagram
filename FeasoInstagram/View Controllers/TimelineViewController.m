//
//  TimelineViewController.m
//  FeasoInstagram
//
//  Created by Jonathan Cabrera on 7/9/18.
//  Copyright © 2018 Jonathan Cabrera. All rights reserved.
//

#import "TimelineViewController.h"
#import "Parse.h"
#import "PostCell.h"
#import "AppDelegate.h"
#import "Post.h"

@interface TimelineViewController () <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *timelinePosts;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPostData];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)didTapLogout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate logout];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    PFObject *post = self.timelinePosts[indexPath.row];
    PFUser *user = post[@"author"];
    PFFile *imageFile = post[@"image"];
    NSDate *date = post[@"timeStamp"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    

    cell.usernameLabel.text = user.username;
    cell.captionLabel.text = post[@"caption"];
    cell.dateLabel.text = dateString;
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!data) {
            return NSLog(@"%@", error);
        }
        cell.postImage.image = [UIImage imageWithData:data];
    }];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.timelinePosts.count;
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [refreshControl endRefreshing];
    [self getPostData];
}

- (void)getPostData{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    [query includeKey:@"caption"];
    [query includeKey:@"image"];
    query.limit = 20;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.timelinePosts = posts;
            [self.tableView reloadData];
            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}



@end
