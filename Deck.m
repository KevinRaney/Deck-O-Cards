//
//  Deck.m
//  OneHandedSolitaire
//
//  Created by Kevin Raney on 1/7/12.
//  Copyright (c) 2012 RDApps. All rights reserved.
//

#import "Deck.h"
#import "Card.h"

@implementation Deck {
    NSMutableArray *cards;
    BOOL jokersAdded;
    BOOL deckIsFull;
}

@synthesize lastCardDrawn = _lastCardDrawn;
@synthesize cardsDrawn = _cardsDrawn;

#pragma mark - NSCoding

#define kCardsKey       @"Cards"
#define kJokersAddedKey @"JokersAdded"
#define kDeckIsFull     @"DeckIsFull"
#define kLastCardDrawn  @"LastCardDrawn"
#define kCardsDrawn     @"CardsDrawn"

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:cards forKey:kCardsKey];
    [aCoder encodeInteger:jokersAdded forKey:kJokersAddedKey];
    [aCoder encodeBool:deckIsFull forKey:kDeckIsFull];
    [aCoder encodeObject:_lastCardDrawn forKey:kLastCardDrawn];
    [aCoder encodeInteger:_cardsDrawn forKey:kCardsDrawn];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        cards = [aDecoder decodeObjectForKey:kCardsKey];
        jokersAdded = [aDecoder decodeIntegerForKey:kJokersAddedKey];
        deckIsFull = [aDecoder decodeBoolForKey:kDeckIsFull];
        _lastCardDrawn = [aDecoder decodeObjectForKey:kLastCardDrawn];
        _cardsDrawn = [aDecoder decodeIntegerForKey:kCardsDrawn];
    }
    return self;
}

#pragma mark - Main

-(id)init {
    if (self = [super init]) {
        if (cards == nil) {
            cards = [[NSMutableArray alloc] initWithCapacity:52];
        } else {
            jokersAdded = NO;
            deckIsFull = NO;
            _cardsDrawn = 0;
            _lastCardDrawn = nil;
            [cards removeAllObjects];
        }
    }
    return self;
}

-(void)logCardPositions {
    BOOL sendDebug = [[[NSUserDefaults alloc] init] boolForKey:@"send_debug"];
    //show the shuffle order in the console
    for (int flCards = 1; flCards <= [cards count]; flCards++) {
        Card *drawnCard = [[Card alloc] init];
        drawnCard = [cards objectAtIndex:flCards-1];
        if (sendDebug) {
            NSLog(@"Card#: %d - %@ of %@",flCards, drawnCard.faceValue, drawnCard.suit);
        }
    }
}

-(id)initWithAllCards {
    if (self = [super init]) { 
        
    } else {
        jokersAdded = NO;
        deckIsFull = NO;
        _cardsDrawn = 0;
        _lastCardDrawn = nil;
    }
    NSString *SuitName;
        
    if (cards == nil) {
        cards = [[NSMutableArray alloc] initWithCapacity:52];
    }
        
    [cards removeAllObjects];
       
    for (int flSuit = 1; flSuit <= 4; flSuit++) {
        
        //Set the Suit Name from the loop variable
        if (flSuit == 1) {
            SuitName = @"Hearts";
        } else if (flSuit == 2) {
            SuitName = @"Diamonds";
        } else if (flSuit == 3) {
            SuitName = @"Spades";
        } else if (flSuit == 4) {
            SuitName = @"Clubs";
        }
            
        // Add cards 1 - 10, Jack, Queen, King & Ace
        for (int flCards = 1; flCards <=13; flCards++) {
            Card *newCard = [[Card alloc] init];
            newCard.suit = SuitName;
            
            if (flCards == 1) {
                newCard.faceValue = @"A";
            } else if (flCards <= 10) {
                newCard.faceValue = [NSString stringWithFormat:@"%d",flCards];
            } else if (flCards == 11) {
                newCard.faceValue = @"J";   
            } else if (flCards == 12) {
                newCard.faceValue = @"Q";   
            } else if (flCards == 13) {
                newCard.faceValue = @"K";   
            } 
            
            [self addCard:newCard];
        }
    }
    
    if ([cards count] == 52) {
        deckIsFull = YES;
    }
    _cardsDrawn = 0;
    
    return self;
}

-(id)initWithAllCardsStacked {
    if (self = [super init]) { 
        
    } else {
        jokersAdded = NO;
        deckIsFull = NO;
        _cardsDrawn = 0;
        _lastCardDrawn = nil;
    }
    
    if (cards == nil) {
        cards = [[NSMutableArray alloc] initWithCapacity:52];
    }
    
    [cards removeAllObjects];
    
    for (int flCards = 1; flCards <=52; flCards++) {
        Card *newCard = [[Card alloc] init];
        
        newCard.faceValue = @"A";
        newCard.suit = @"Hearts";
            
        [self addCard:newCard];
    }
    
    if ([cards count] == 52) {
        deckIsFull = YES;
    }
    _cardsDrawn = 0;
    
    return self;
}

-(id)initWithLosingHand {
    if (self = [super init]) { 
        
    } else {
        jokersAdded = NO;
        deckIsFull = NO;
        _cardsDrawn = 0;
        _lastCardDrawn = nil;
    }
    
    if (cards == nil) {
        cards = [[NSMutableArray alloc] initWithCapacity:52];
    }
    
    [cards removeAllObjects];

    for (int forCards = 1; forCards <=4; forCards++) {
        Card *newCard = [[Card alloc] init];
    
        if (forCards == 1) {
            newCard.faceValue = @"A";
            newCard.suit = @"Hearts";
        } else if (forCards == 2) {
            newCard.faceValue = @"2";
            newCard.suit = @"Diamonds";
        } else if (forCards == 3) {
            newCard.faceValue = @"8";
            newCard.suit = @"Clubs";
        } else if (forCards == 4) {
            newCard.faceValue = @"5";
            newCard.suit = @"Spades";
        }

        [self addCard:newCard];
    }
    
    return self;
}

int randomSort(id obj1, id obj2, void *context ) {
	// returns random number -1 0 1
	return (arc4random()%3 - 1);
}

-(void)shuffleDeck {
	for (int x = 0; x < 500; x++) {
		[cards sortUsingFunction:randomSort context:nil];
	}
}

-(BOOL)cutDeck {
    NSMutableArray *deck1 = [[NSMutableArray alloc] init];
    NSMutableArray *deck2 = [[NSMutableArray alloc] init];
    NSInteger actualCutPosition;
    NSRange cutPosition;
    
    actualCutPosition = (arc4random() % [cards count]);
    if (actualCutPosition == 0) {
        actualCutPosition = ([cards count] / 2) + 1;
    }
    cutPosition.location = actualCutPosition - 1;
    cutPosition.length = [cards count] - cutPosition.location;
    
    [deck2 addObjectsFromArray:[cards subarrayWithRange:cutPosition]];
    
    cutPosition.length = cutPosition.location;
    cutPosition.location = 0;
    
    [deck1 addObjectsFromArray:[cards subarrayWithRange:cutPosition]];
    
    [cards removeAllObjects];
    [cards addObjectsFromArray:deck2];
    [cards addObjectsFromArray:deck1];
    
    if ([[[NSUserDefaults alloc] init] boolForKey:@"send_debug"]) {
        [self logCardPositions];
    }
    
    return YES;
}

-(void)AddJokers {
    Card *aJoker = [[Card alloc] init];
    
    aJoker.faceValue = @"Joker";
    
    if (jokersAdded == NO && deckIsFull == YES) {
        aJoker.suit = @"Red";
        [self addCard:aJoker];
        
        aJoker.suit = @"Black";
        [self addCard:aJoker];
    } else {
        if ([[[NSUserDefaults alloc] init] boolForKey:@"send_debug"]) {
            NSLog(@"Jokers can only be added once and there must be no cards drawn.");
        }
    }
}

-(Card *)drawNextCard {
    if ([cards count] > 0) {
        Card *drawnCard = [[Card alloc] init];
        drawnCard = [cards objectAtIndex:0]; 
        [cards removeObjectAtIndex:0];
        deckIsFull = NO;
        _cardsDrawn++;
        _lastCardDrawn = drawnCard;
        return drawnCard;
    } else {
        if ([[[NSUserDefaults alloc] init] boolForKey:@"send_debug"]) {
            NSLog(@"There are no more cards to draw");
        }
        return nil;
    }
    
}

-(NSInteger)cardsInDeck {
    return [cards count];
}

-(void)addCard:(Card *)cardToAdd {
    [cards addObject:cardToAdd];
}

-(void)buryCard:(Card *)cardToBury {

    [cards insertObject:cardToBury atIndex:(arc4random() % [cards count])];
    _cardsDrawn--;
}

-(Card *)viewCardAtIndex:(NSInteger)index {
    if (index < [cards count]) {
        return [cards objectAtIndex:index];
    } else {
        NSLog(@"The index is not valid");
        return nil;
    }
}

-(void)removeCardAtIndex:(NSInteger)index {
    if (index < [cards count]) {
        [cards removeObjectAtIndex:index];
    } else {
        NSLog(@"The index is not valid");
    }
}

-(NSInteger)suitsRemaining:(NSString *)suit {
    NSInteger suitCount = 0;
    
    for (Card *loopCard in cards) {
        if ([loopCard.suit isEqualToString:suit]) {
            suitCount ++;
        }
    };
    
    return suitCount;
}

-(NSInteger)facecardsRemaining:(NSString *)faceValue {
    NSInteger faceValueCount = 0;
    
    for (Card *loopCard in cards) {
        if ([loopCard.suit isEqualToString:faceValue]) {
            faceValueCount ++;
        }
    };
    
    return faceValueCount;
}

@end
