//
//  TDProfileHomeHeaderView.m
//  TDEarthVillage
//
//  Created by Hank on 2017/7/5.
//  Copyright © 2017年 Hank. All rights reserved.
//

#import "TDProfileHomeHeaderView.h"

@interface TDProfileHomeHeaderView()

@property (weak, nonatomic) IBOutlet UIImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblNumber;


@end

@implementation TDProfileHomeHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    if([TDUserInfoModel isLogin]){
        [self userLogin];
    }else{
        [self userLogout];
    }
    kUserLoginWithSelector(userLogin)
    kUserLogoutWithSelector(userLogout)
}

- (void)setUserInfo{
    if([TDUserInfoModel isLogin]){
        [self userLogin];
    }else{
        [self userLogout];
    }
}

#pragma mark - ACTION

- (IBAction)editAction:(UIButton *)sender {
    kHankCallBlock(_editBlock);
}

- (void)userLogin{
    _lblName.text = kHankUnNilStr(kCurrentUser.nickName);
    _lblNumber.text = kHankUnNilStr(kCurrentUser.phone);
    [_imgPic sd_setImageWithURL:[NSURL URLWithString:kHankUnNilStr(kCurrentUser.logo)] placeholderImage:[UIImage imageNamed:@"me_portrait_3"]];
}

- (void)userLogout{
    _lblName.text = _lblNumber.text = @"";
    _imgPic.image = [UIImage imageNamed:@"me_portrait_3"];
}

@end
