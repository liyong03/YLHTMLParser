//
//  YLHTMLParser.m
//  AttributedLabel Example
//
//  Created by Yong Li on 5/19/14.
//
//

#import "YLHTMLParser.h"
#import <OHAttributedLabel/NSAttributedString+Attributes.h>

typedef NS_ENUM(NSUInteger, YLHTMLTag) {
    YLHTMLNone = 0,
    YLHTMLLink,
    YLHTMLBold,
    YLHTMLItalic
};

@interface ElementObj : NSObject
@property (nonatomic, assign) YLHTMLTag elementTag;
@end

@implementation ElementObj
@synthesize elementTag;
@end

@interface LinkElementObj : ElementObj
@property (nonatomic, retain) NSURL* url;
@end

@implementation LinkElementObj
@synthesize url;
@end

@interface YLHTMLParser()<NSXMLParserDelegate>

@end

@implementation YLHTMLParser {
    NSMutableAttributedString* _result;
    NSMutableArray* _elementStack;
    UIFont* _baseFont;
}

+ (YLHTMLParser*)sharedParser {
    static YLHTMLParser* sharedParser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedParser = [[YLHTMLParser alloc] init];
    });
    
    return sharedParser;
}

- (id)init
{
    self = [super init];
    if (self) {
        _elementStack = [NSMutableArray array];
        _baseFont = [UIFont systemFontOfSize:14.f];
    }
    return self;
}

- (NSMutableAttributedString*)attributedStringByProcessingHTMLString:(NSString*)string withBaseFont:(UIFont*)font {
    _result = [[NSMutableAttributedString alloc] init];
    if (font)
        _baseFont = font;
    
    NSString* pString = [NSString stringWithFormat:@"<body>%@</body>", string];
    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:[pString dataUsingEncoding:NSUTF8StringEncoding]];
    parser.delegate = self;
    [parser parse];
    
    return _result;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    NSLog(@"didStartElement: %@", elementName);
    if ([elementName isEqualToString:@"a"]) {
        LinkElementObj* obj = [[LinkElementObj alloc] init];
        obj.elementTag = YLHTMLLink;
        obj.url = [NSURL URLWithString:attributeDict[@"href"]];
        [_elementStack addObject:obj];
    }
    else if ([elementName isEqualToString:@"b"] || [elementName isEqualToString:@"strong"]) {
        ElementObj* obj = [[ElementObj alloc] init];
        obj.elementTag = YLHTMLBold;
        [_elementStack addObject:obj];
    }
    else if ([elementName isEqualToString:@"i"]) {
        ElementObj* obj = [[ElementObj alloc] init];
        obj.elementTag = YLHTMLItalic;
        [_elementStack addObject:obj];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    NSLog(@"didEndElement: %@", elementName);
    [_elementStack removeLastObject];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSLog(@"foundCharacters: %@", string);
    NSMutableAttributedString* attributedStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedStr setFont:_baseFont];
    
    for (ElementObj* obj in _elementStack) {
        switch (obj.elementTag) {
            case YLHTMLLink:
            {
                LinkElementObj* linkObj = (LinkElementObj*)obj;
                [attributedStr setLink:linkObj.url range:NSMakeRange(0, string.length)];
            }
                break;
                
            case YLHTMLBold:
            {
                [attributedStr setTextBold:YES range:NSMakeRange(0, string.length)];
            }
                break;
                
            case YLHTMLItalic:
            {
                [attributedStr setTextItalics:YES range:NSMakeRange(0, string.length)];
            }
                break;
                
            default:
                break;
        }
    }
    [_result appendAttributedString:attributedStr];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
  NSLog(@"Error : %@", parseError);
}


@end
