//
//  WAViewController.m
//  WebpCompressDemo
//
//  Created by KakaCompany on 6/3/15.
//  Copyright (c) 2015 KakaCompany. All rights reserved.
//

#import "WAViewController.h"
#import "WAWebpCompressUtil.h"

@interface WAViewController ()

@end

@implementation WAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addPhoto:(id)sender
{
  UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"本地",nil];
  [sheet showInView:self.view];
  [sheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
  if (buttonIndex == 0)
  {
    [self takePhoto];
  }
  else if(buttonIndex == 1)
  {
    [self chooseFromLocal];
  }
}

- (void)takePhoto
{
  UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
  if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
  {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    //设置拍照后的图片可被编辑
    picker.allowsEditing = YES;
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
    [picker release];
  }else
  {
    NSLog(@"模拟其中无法打开照相机,请在真机中使用");
  }
}

- (void)chooseFromLocal
{
  UIImagePickerController *picker = [[UIImagePickerController alloc] init];
  
  picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  picker.delegate = self;
  //设置选择后的图片可被编辑
  picker.allowsEditing = YES;
  [self presentViewController:picker animated:YES completion:nil];
  [picker release];
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
  [picker dismissViewControllerAnimated:YES completion:nil];
  //当选择的类型是图片
  if ([type isEqualToString:@"public.image"])
  {
    UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self.iImageView setImage:image];
    [CWAWebpCompressUtil compressToWebpWithImage:image withBlock:^(NSData *resultData, NSError *error)
     {
     }];
  }
}

- (void)dealloc {
  [_iImageView release];
  [super dealloc];
}
@end
