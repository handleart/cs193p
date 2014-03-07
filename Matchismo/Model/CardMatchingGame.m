//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Art Mostofi on 2/27/14.
//  Copyright (c) 2014 Art Mostofi. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Deck.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSInteger playPoints; //game points earned or lost
@property (nonatomic, strong) NSMutableArray *cards; // of Cards
@property (nonatomic, strong) NSMutableArray *cardsChosen; // of Cards
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

- (NSMutableArray *)cardsChosen {
    if (!_cardsChosen) _cardsChosen = [[NSMutableArray alloc]init];
    return _cardsChosen;
}

- (NSInteger) matchNumberOfCards {
    if (!_matchNumberOfCards) _matchNumberOfCards = 2;
    return _matchNumberOfCards;
}

static const int MISMATCH_PENALITY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

-(void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];

    NSLog(@"S: %i", self.matchNumberOfCards);

/*    if (self.matchNumberOfCards == 2) {
        if (!card.isMatched) {
            if (card.isChosen) {
                card.chosen = NO;
            } else {
                // match against other cards
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        int matchScore = [card match:@[otherCard]];
                        NSLog(@"Match Score: %i", matchScore);
                        if (matchScore) {
                            self.score  += matchScore * MATCH_BONUS;
                            otherCard.matched = YES;
                            card.matched = YES;
                            
                        } else {
                            self.score -= MISMATCH_PENALITY;
                            otherCard.chosen = NO;
                        }
                        break; // can only choose 2 cards for now
                    }
                }
                self.score -= COST_TO_CHOOSE;
                //NSLog(@"Score is: %i", self.score);
                card.chosen = YES;
            }
        }
    }
  */
    if (self.matchNumberOfCards > 1){
        
        if ([self.cardsChosen count] == self.matchNumberOfCards) {
            self.cardsChosen = nil;
            self.playPoints = 0;
        }
        
        // need to figure out if 3 cards are chose
        if (!card.isMatched) {
            if (card.isChosen) {
                card.chosen = NO;
                if (card) {[self.cardsChosen  removeObject:card];}
            } else {
                if (card) {[self.cardsChosen addObject:card];}
                
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
                
                if ([self.cardsChosen count] == self.matchNumberOfCards) {
                    NSLog(@"Number of cards chosen %i", [self.cardsChosen count]);
                    // match against other cards
                    
                    int matchScore = 0;
                    
                    NSMutableArray *cardsChosenCopy = [NSMutableArray arrayWithArray:self.cardsChosen];
                    
                    for (Card *chosenCard in self.cardsChosen) {
                        [cardsChosenCopy removeObject:chosenCard];
                        //if (cardsChosenCopy) {
                        matchScore += [chosenCard match:cardsChosenCopy];
                        //}
                    }
                    
                    NSLog(@"Match Score: %i", matchScore);
                    if (matchScore) {
                        self.playPoints += matchScore * MATCH_BONUS;
                        self.score  += matchScore * MATCH_BONUS;
                        for (Card *chosenCards in self.cardsChosen) {
                            chosenCards.matched = YES;
                        }
                    } else {
                        self.playPoints -= MISMATCH_PENALITY;
                        self.score -= MISMATCH_PENALITY;
                        for (Card *chosenCards in self.cardsChosen) {
                            chosenCards.chosen = NO;
                        }
                    }
                
                
                    
                }
                    //self.score -= COST_TO_CHOOSE;
                    //NSLog(@"Score is: %i", self.score);

                    
            }
            
        }
        
    }
}

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [self init]; // super's designated initilizer

    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
               [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
    
}

-(Card *)cardAtIndex:(NSUInteger)index {
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

@end
