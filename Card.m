//
//  Card.m
//  OneHandedSolitaire
//
//  Created by Kevin Raney on 1/7/12.
//  Copyright (c) 2012 RDApps. All rights reserved.
//

#import "Card.h"

@implementation Card

@synthesize suit = _suit;
@synthesize faceValue = _faceValue;

#pragma mark - NSCoding

#define kSuitKey        @"Suit"
#define kFaceValueKey   @"FaceValue"

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_suit forKey:kSuitKey];
    [aCoder encodeObject:_faceValue forKey:kFaceValueKey];
}

-(id)initWithCoder:(NSCoder *)aDecoder {

    if (self = [super init]) {
        _suit = [aDecoder decodeObjectForKey:kSuitKey];
        _faceValue = [aDecoder decodeObjectForKey:kFaceValueKey];
    }
    return self;
}

#pragma mark - Main

-(NSString *)description {
    return [[_faceValue stringByAppendingString:@" of "] stringByAppendingString:_suit];
}

-(NSString *)faceValueProper {
    if (_faceValue.length > 0) {
        if ([_faceValue isEqualToString:@"A"]) {
            return @"Ace";
        } else if ([_faceValue isEqualToString:@"K"]) {
            return @"King";
        } else if ([_faceValue isEqualToString:@"Q"]) {
            return @"Queen";
        } else if ([_faceValue isEqualToString:@"J"]) {
            return @"Jack";
        } else if ([_faceValue isEqualToString:@"Joker"]) {
            if ([_faceValue isEqualToString:@"Red"]) {
                return @"Red Joker";
            } else if ([_faceValue isEqualToString:@"Black"]) {
                return @"Black Joker";  
            }
        } else {
            return _faceValue;
        }
    }
    return nil;
}
    
-(NSString *)suitColor {
    if ([_suit isEqualToString:@"Hearts"] || [_suit isEqualToString:@"Diamonds"]) {
        return @"Red";
    } else if ([_suit isEqualToString:@"Clubs"] || [_suit isEqualToString:@"Spades"]) {
        return @"Black";
    } else {
        return nil;
    }
}

-(NSString *)cardImageFileName {
    NSString *fileName = [[NSString alloc] init];
    
    if (_faceValue.length > 0) {
        if ([_faceValue isEqualToString:@"A"]) {
            fileName = [fileName stringByAppendingString:@"ace_of_"];
        } else if ([_faceValue isEqualToString:@"K"]) {
            fileName = [fileName stringByAppendingString:@"king_of_"];
        } else if ([_faceValue isEqualToString:@"Q"]) {
            fileName = [fileName stringByAppendingString:@"queen_of_"];
        } else if ([_faceValue isEqualToString:@"J"]) {
            fileName = [fileName stringByAppendingString:@"jack_of_"];
        } else if ([_faceValue isEqualToString:@"Joker"]) {
            if ([_faceValue isEqualToString:@"Red"]) {
                fileName = [fileName stringByAppendingString:@"red_joker.png"];
            } else if ([_faceValue isEqualToString:@"Black"]) {
                fileName = [fileName stringByAppendingString:@"black_joker.png"];
            }
        } else {
            fileName = [fileName stringByAppendingFormat:@"%@_of_",_faceValue];
        }
        
        if ([_suit isEqualToString:@"Hearts"]) {
            fileName = [fileName stringByAppendingString:@"hearts.png"];
        } else if ([_suit isEqualToString:@"Diamonds"]) {
            fileName = [fileName stringByAppendingString:@"diamonds.png"];
        } else if ([_suit isEqualToString:@"Clubs" ]) {
            fileName = [fileName stringByAppendingString:@"clubs.png"];
        } else if ([_suit isEqualToString:@"Spades"]) {
            fileName = [fileName stringByAppendingString:@"spades.png"];
        }
        return fileName;
    }
    return nil;
}

-(UIImage *)cardImageHilighted {
    
    //return [UIImage imageNamed:[NSString stringWithFormat:@"HL_%@",[self cardImageFileName]]];
   
    UIImage *cardImage = [UIImage imageNamed:[self cardImageFileName]];
    UIColor *tintColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.4 alpha:1.0];
    
    UIGraphicsBeginImageContextWithOptions(cardImage.size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, cardImage.size.width, cardImage.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSaveGState(ctx);
    CGContextClipToMask(ctx, area, cardImage.CGImage);
    
    [tintColor set];
    CGContextFillRect(ctx, area);
    
    CGContextRestoreGState(ctx);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextDrawImage(ctx, area, cardImage.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

-(UIImage *)cardImage {
    return [UIImage imageNamed:[self cardImageFileName]];
}

@end
