//
//  YLHTMLParser.h
//  AttributedLabel Example
//
//  Created by Yong Li on 5/19/14.
//
//

#import <Foundation/Foundation.h>

@interface YLHTMLParser : NSObject

- (NSMutableAttributedString*)attributedStringByProcessingHTMLString:(NSString*)string withBaseFont:(UIFont*)font;

@end
