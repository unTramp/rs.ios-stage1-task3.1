#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>

@property (retain, nonatomic) UILabel *labelResultColor;
@property (retain, nonatomic) UILabel *labelRed;
@property (retain, nonatomic) UILabel *labelGreen;
@property (retain, nonatomic) UILabel *labelBlue;

@property (retain, nonatomic) UIView *viewResultColor;
@property (retain, nonatomic) UITextField *textFieldRed;
@property (retain, nonatomic) UITextField *textFieldGreen;
@property (retain, nonatomic) UITextField *textFieldBlue;

@property (retain, nonatomic) UIButton *buttonProcess;


@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UITextField *textfield;

@end

