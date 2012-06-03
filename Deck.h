//
//  Deck.h
//  OneHandedSolitaire
//
//  Created by Kevin Raney on 1/7/12.
//  Copyright (c) 2012 RDApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Card;

@interface Deck : NSObject <NSCoding>

@property (nonatomic, retain) Card *lastCardDrawn;
@property (nonatomic) NSInteger cardsDrawn;

-(id)initWithAllCards;
-(id)initWithAllCardsStacked;
-(id)initWithLosingHand;
int randomSort(id obj1, id obj2, void *context);
-(void)shuffleDeck;
-(BOOL)cutDeck;
-(void)AddJokers;
-(Card *)drawNextCard;
-(NSInteger)cardsInDeck;
-(void)addCard:(Card *)cardToAdd;
-(void)buryCard:(Card *)cardToBury;
-(Card *)viewCardAtIndex:(NSInteger)index;
-(void)removeCardAtIndex:(NSInteger)index;
-(NSInteger)suitsRemaining:(NSString *)suit;
-(NSInteger)facecardsRemaining:(NSString *)faceValue;

@end
