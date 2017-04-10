//
//  ZYXImageFrameCell.m
//  TourNote
//
//  Created by 极客天地 on 2017/3/7.
//  Copyright © 2017年 极客天地. All rights reserved.
//

#import "ZYXImageFrameCell.h"
#import "ZYXImageFrameModel.h"
@interface ZYXImageFrameCell()
@property (weak, nonatomic) IBOutlet UIView *customSelectedView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong,nonatomic) ZYXImageFrameModel * model;
@end
@implementation ZYXImageFrameCell
-(UIImage *)showFrameImage{
    return self.imageView.image;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)initData{

}

-(void)initUI{
    self.selectedBackgroundView = self.customSelectedView;
}
-(void)refreshUI{
    UIImage * image = [UIImage imageWithContentsOfFile:self.model.imageLocalPath];
    self.imageView.image = image;
}

-(void)setCellWithModel:(id)model{
    self.model = model;
    [self refreshUI];
}
@end
