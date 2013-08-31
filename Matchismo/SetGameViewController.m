#import "SetGameViewController.h"
#import "CardGame.h"


@interface SetGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameStatusLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (nonatomic) CardGame *game;

@end


@implementation SetGameViewController

- (void)updateUI {
    // ● ■ ▲    
}

- (IBAction)deal {
}

@end
