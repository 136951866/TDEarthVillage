//
//  TDOrderSubCell.h
//  TDEarthVillage
//
//  Created by Hank on 2017/7/10.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import <UIKit/UIKit.h>

const static CGFloat kTDOrderSubCellHeight = 25.0f;

@interface TDOrderSubCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblNum;

@end
