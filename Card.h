//
//  Card.h
//  OneHandedSolitaire
//
//  Created by Kevin Raney on 1/7/12.
//  Copyright (c) 2012 RDApps. All rights reserved.
//
//  Images:
//  This Class assumes that you have a collection of images that conform 
//  to [faceValue]_of_[suit]s.png and HL_[faceValue]_of_[suit]s.png included
//  in your project.
//
//

#import <Foundation/Foundation.h>

@interface Card : NSObject <NSCoding>

@property (nonatomic, strong) NSString *suit;
@property (nonatomic, strong) NSString *faceValue;

-(NSString *)description;
-(NSString *)faceValueProper;
-(NSString *)suitColor;
-(NSString *)cardImageFileName;
-(UIImage *)cardImage;
-(UIImage *)cardImageHilighted;

@end
