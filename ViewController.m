//
//  ViewController.m
//  XyCachesManager.h XyCachesManager
//
//  Created by mac on 16/8/30.
//  Copyright © 2016年 Xydawn. All rights reserved.
//

#import "ViewController.h"
#import "XyCachesManager.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textString;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)btnClick:(id)sender {
    
    NSLog(@"%@",[XyCachesManager setNSDocumentDirectoryWith:self.textString.text withPahtName:@"textString"]);
    
    self.textString.text = @"已储存";
    
}
- (IBAction)readBtn:(id)sender {
    
    self.textString.text = [XyCachesManager getNSDocumentDirectoryWithPahtName:@"textString"];
}
- (IBAction)getCahes:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"缓存太小，查出来可能为0" message:[NSString stringWithFormat:@"%f",[XyCachesManager getCachesSize]] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
    
}
- (IBAction)deleteBtn:(id)sender {
    
    [XyCachesManager deletCachesSize];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
