//
//  PostCell.h
//  FeasoInstagram
//
//  Created by Jonathan Cabrera on 7/10/18.
//  Copyright © 2018 Jonathan Cabrera. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

@end
