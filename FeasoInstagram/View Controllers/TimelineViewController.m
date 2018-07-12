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
//    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
//    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
//    [self.tableView insertSubview:refreshControl atIndex:0];
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    [query includeKey:@"caption"];
    [query includeKey:@"image"];
    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.timelinePosts = posts;
//            NSLog(@"%@", self.timelinePosts);
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)didTapLogout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate logout];
}

//- (void)onTimer {
//    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
//    [query orderByDescending:@"createdAt"];
//    [query includeKey:@"author"];
//    query.limit = 20;
//
//    // fetch data asynchronously
//    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
//        if (posts != nil) {
//            self.timelinePosts = posts;
//
//            [self.tableView reloadData];
//        } else {
//            NSLog(@"%@", error.localizedDescription);
//        }
//    }];
//}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    
    PFObject *post = [PFObject objectWithClassName:@"Post"];
    


    NSLog(@"%@", post);


    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.timelinePosts.count;
}

//- (void)beginRefresh:(UIRefreshControl *)refreshControl {
//    
//    // Create NSURL and NSURLRequest
//    
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
//                                                          delegate:nil
//                                                     delegateQueue:[NSOperationQueue mainQueue]];
//    session.configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
//    
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//                                                
//                                                // ... Use the new data to update the data source ...
//
//                                                // Reload the tableView now that there is new data
//                                                [self.tableView reloadData];
//                                                
//                                                // Tell the refreshControl to stop spinning
//                                                [refreshControl endRefreshing];
//                                                
//                                            }];
//    
//    [task resume];
//}

@end
