//
//  TDWebViewCell.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/11.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTDWebViewCellDidFinishLoad @"TDWebViewCellDidFinishLoad"

@interface TDWebViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIWebView *webView;
    
@end
