//
//  InstagramFeedTableViewCell.m
//  SelfSizeCellDemo
//
//  Created by 杨晴贺 on 24/11/2016.
//  Copyright © 2016 silence. All rights reserved.
//

#import "InstagramFeedTableViewCell.h"
#import "InstagramItem.h"
#import "WPHotspotLabel.h"

@implementation InstagramFeedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CGFloat radio = CGRectGetWidth(self.leftCircleView.bounds) / 2.0;
    self.leftCircleView.layer.cornerRadius = radio;
    self.centerCircleView.layer.cornerRadius = radio;
    self.rightCircleView.layer.cornerRadius = radio;
}

- (void)setInstagramItem:(InstagramItem *)instagramItem{
    _instagramItem = instagramItem ;
    self.likeLabel.text = [NSString stringWithFormat:@"%@ 次赞", instagramItem.likeCount];
    
    if (instagramItem.attrbutedComment) {
        self.commentLabel.attributedText = instagramItem.attrbutedComment;
    } else {
        self.commentLabel.attributedText = [self filterLinkWithContent:instagramItem.comment];
    }
}

- (NSMutableAttributedString *)filterLinkWithContent:(NSString *)content {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSError *error = NULL;
    NSDataDetector *detector =
    [NSDataDetector dataDetectorWithTypes:(NSTextCheckingTypes)NSTextCheckingTypeLink | NSTextCheckingTypePhoneNumber
                                    error:&error];
    NSArray *matches = [detector matchesInString:content
                                         options:0
                                           range:NSMakeRange(0, [content length])];
    for (NSTextCheckingResult *match in matches) {
        
        if (([match resultType] == NSTextCheckingTypeLink)) {
            
            NSURL *url = [match URL];
            [attributedString addAttribute:NSLinkAttributeName value:url range:match.range];
        }
    }
    return attributedString;
}



@end
