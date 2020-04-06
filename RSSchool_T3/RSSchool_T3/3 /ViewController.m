#import "ViewController.h"

@implementation ViewController

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
    [self setUpFrames];
    [self setAccessibilityIdentifires];
}

- (void)setUpViews {
    
    self.viewResultColor = [[UIView alloc] init];
    self.viewResultColor.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:self.viewResultColor];
    
    self.labelResultColor = [[UILabel alloc] init];
    self.labelRed = [[UILabel alloc] init];
    self.labelGreen = [[UILabel alloc] init];
    self.labelBlue = [[UILabel alloc] init];
    self.labelResultColor.text = @"Color";
    self.labelRed.text = @"RED";
    self.labelGreen.text = @"GREEN";
    self.labelBlue.text = @"BLUE";
    [self.view addSubview:self.labelResultColor];
    [self.view addSubview:self.labelRed];
    [self.view addSubview:self.labelGreen];
    [self.view addSubview:self.labelBlue];
   
    self.textFieldRed = [[UITextField alloc] init];
    self.textFieldGreen = [[UITextField alloc] init];
    self.textFieldBlue = [[UITextField alloc] init];
    self.textFieldRed.placeholder = @"0..255";
    self.textFieldGreen.placeholder = @"0..255";
    self.textFieldBlue.placeholder = @"0..255";
    [self.view addSubview:self.textFieldRed];
    [self.view addSubview:self.textFieldGreen];
    [self.view addSubview:self.textFieldBlue];
    self.textFieldRed.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldGreen.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldBlue.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldRed.delegate = self;
    self.textFieldGreen.delegate = self;
    self.textFieldBlue.delegate = self;
    
    self.buttonProcess = [[UIButton alloc] init];
    [self.buttonProcess setTitle:@"Process" forState:UIControlStateNormal];
    [self.buttonProcess setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.buttonProcess addTarget:self action:@selector(processButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonProcess];
}

- (void)setUpFrames {
    
    NSArray<UILabel *> *labels = @[self.labelResultColor, self.labelRed, self.labelGreen, self.labelBlue];
    CGRect labelFrame = CGRectMake(20, 80, 100, 50);
    for (int i = 0; i < labels.count; i++) {
        labels[i].frame = labelFrame;
        labelFrame.origin.y += 60;
    }
    
    NSArray<UITextField *> *textFields = @[self.textFieldRed, self.textFieldGreen, self.textFieldBlue];
    CGRect textFieldFrame = CGRectMake(labelFrame.size.width, 150, self.view.bounds.size.width - labelFrame.size.width - 40, 30);
    for (int i = 0; i < textFields.count; i++) {
        textFields[i].frame = textFieldFrame;
        textFieldFrame.origin.y += 60;
    }
    
    self.viewResultColor.frame = CGRectMake(120, 85, self.view.bounds.size.width - 60 - labelFrame.size.width, 40);
    self.buttonProcess.frame = CGRectMake(self.view.center.x - 60, self.textFieldBlue.frame.origin.y + 60, 120, 40);
}


- (void)processButtonTapped {
    float red = [self.textFieldRed.text floatValue];
    float green = [self.textFieldGreen.text floatValue];
    float blue = [self.textFieldBlue.text floatValue];
    
    void (^errorBlock)(void) = ^{
        self.labelResultColor.text = @"Error";
        self.viewResultColor.backgroundColor = [UIColor clearColor];
    };
    
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([self.textFieldRed.text rangeOfCharacterFromSet:notDigits].location == NSNotFound &&
        [self.textFieldGreen.text rangeOfCharacterFromSet:notDigits].location == NSNotFound &&
        [self.textFieldBlue.text rangeOfCharacterFromSet:notDigits].location == NSNotFound)
    {
        if (self.textFieldRed.text.length > 0 && self.textFieldGreen.text.length > 0 && self.textFieldBlue.text.length > 0) {
            if ( red < 255 && green < 255 && blue < 255 && red > 0 && green > 0 && blue > 0 ) {
                UIColor *myColor = [UIColor colorWithRed:red/255 green:green/255 blue:blue/255 alpha:1];
                self.viewResultColor.backgroundColor = myColor;
                self.labelResultColor.text = [self hexStringForColor:(myColor)];
            } else {
                errorBlock();
            }
        } else {
            errorBlock();
        }
    } else {
        errorBlock();
    }
    [self clear];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.labelResultColor.text = @"Color";
}

- (void)setAccessibilityIdentifires {
    self.view.accessibilityIdentifier = @"mainView";
    self.textFieldRed.accessibilityIdentifier = @"textFieldRed";
    self.textFieldGreen.accessibilityIdentifier = @"textFieldGreen";
    self.textFieldBlue.accessibilityIdentifier = @"textFieldBlue";
    self.buttonProcess.accessibilityIdentifier = @"buttonProcess";
    self.labelRed.accessibilityIdentifier = @"labelRed";
    self.labelGreen.accessibilityIdentifier = @"labelGreen";
    self.labelBlue.accessibilityIdentifier = @"labelBlue";
    self.labelResultColor.accessibilityIdentifier = @"labelResultColor";
    self.viewResultColor.accessibilityIdentifier = @"viewResultColor";
}

- (void)clear {
    self.textFieldRed.text = @"";
    self.textFieldGreen.text = @"";
    self.textFieldBlue.text = @"";
    [self.textFieldRed resignFirstResponder];
    [self.textFieldGreen resignFirstResponder];
    [self.textFieldBlue resignFirstResponder];
}

- (NSString *)hexStringForColor:(UIColor *)color {
      const CGFloat *components = CGColorGetComponents(color.CGColor);
      CGFloat r = components[0];
      CGFloat g = components[1];
      CGFloat b = components[2];
      NSString *hexString=[NSString stringWithFormat:@"0x%02X%02X%02X", (int)(r * 255), (int)(g * 255), (int)(b * 255)];
      return hexString;
}

@end
