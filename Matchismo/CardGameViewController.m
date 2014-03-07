//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Art Mostofi on 2/21/14.
//  Copyright (c) 2014 Art Mostofi. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "PlayingCard.h"

@interface CardGameViewController ()
@property (strong, nonatomic)CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UITextField *matchTypeLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UIButton *dealMeButton;
@property (weak, nonatomic) IBOutlet UISwitch *matchTypeSwitch;
@property (nonatomic) int numberOfCardsToMatch;
@property (weak, nonatomic) IBOutlet UILabel *gameNarrative;
@end

@implementation CardGameViewController

- (int)numberOfCardsToMatch {
    if (!_numberOfCardsToMatch) _numberOfCardsToMatch = 2;
    return _numberOfCardsToMatch;
}

- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    _game.matchNumberOfCards = self.numberOfCardsToMatch;
    return _game;
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

-(IBAction)touchCardButton:(UIButton *)sender {
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    
    //Don't allow user to change game type once the game has started
    self.matchTypeSwitch.enabled = NO;
    [self updateUI];
}

- (IBAction)touchDealMeButton:(UIButton *)sender {
    //reset game and restart the process
    self.game = nil;
    self.matchTypeSwitch.enabled = YES;
    [self updateUI];
}

- (IBAction)touchMatchTypeSwitch:(UISwitch *)sender {
    //change card match game
    
    if (self.matchTypeSwitch.isOn) {
        self.numberOfCardsToMatch = 2;
    } else {
        self.numberOfCardsToMatch = 3;
    }
    
    self.game.matchNumberOfCards = self.numberOfCardsToMatch;
    
     NSLog(@"Match Number of Cards %i", self.game.matchNumberOfCards);
    self.matchTypeLabel.text = [NSString stringWithFormat:@"%i Card Match Game", self.game.matchNumberOfCards];
}

-(void)updateGameNarrative {
    NSString *gameNarrative;
    
    for (PlayingCard *card in self.game.cardsChosen) {
        gameNarrative = [NSString stringWithFormat:@"%@%i%@", (gameNarrative ? gameNarrative : @"" ), card.rank, card.suit ];
    }
    
    
    
    if (self.game.playPoints < 0) {
        gameNarrative = [NSString stringWithFormat:@"%@ did not match! %i points penality.", gameNarrative, self.game.playPoints*(-1)];
    } else if (self.game.playPoints > 0) {
        gameNarrative = [NSString stringWithFormat:@"Matched %@ for %i points.", gameNarrative, self.game.playPoints];
    }
    
    self.gameNarrative.text = gameNarrative;
    
}

-(void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        //NSLog(@"IS chosen for card: %hhd", card.isChosen);
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
    
    [self updateGameNarrative];

}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
