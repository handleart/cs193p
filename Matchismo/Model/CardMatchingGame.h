//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Art Mostofi on 2/27/14.
//  Copyright (c) 2014 Art Mostofi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

//designated initializer
-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;

@property(nonatomic, readonly) NSInteger score;
@property(nonatomic, readwrite) NSInteger matchNumberOfCards;
@property (nonatomic, readonly) NSInteger playPoints;
@property (nonatomic, readonly) NSMutableArray *cardsChosen;

@end
