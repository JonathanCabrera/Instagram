//
//  ComposeViewController.m
//  FeasoInstagram
//
//  Created by Jonathan Cabrera on 7/10/18.
//  Copyright © 2018 Jonathan Cabrera. All rights reserved.
//

#import "ComposeViewController.h"
#import "Post.h"

@interface ComposeViewController () < UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImage *savedImage;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)didTapUpload:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePickerVC animated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *originalImage = info[UIImagePickerControllerEditedImage];
    self.savedImage = originalImage;
    UIImage *resizedImage = [self resizeImage:self.savedImage withSize:CGSizeMake(375, 375)];
    self.uploadImage.image = resizedImage;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)didTapCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapShare:(id)sender {
    [Post postUserImage:self.uploadImage.image withCaption:self.captionField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded){
            [self dismissViewControllerAnimated:YES completion:nil];
            NSLog(@"successful!");
        } else {
            NSLog(@"Didn't work");
        }
    }];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}





@end
