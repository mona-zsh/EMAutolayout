//
//  ViewController.m
//  EMAutolayout
//
//  Created by Mona Zhang on 10/27/15.
//  Copyright © 2015 Eskimona. All rights reserved.
//

#import "UIColor+EMColor.h"

#import "EMView.h"

#import "ViewController.h"

@interface ViewController ()


@property (nonatomic) UIView *topView;
@property (nonatomic) EMView *exampleView;
@property (nonatomic) UIView *bottomView;

@end

@implementation ViewController

- (EMView *)exampleView {
    if (!_exampleView) {
        _exampleView = [[EMView alloc] init];
        _exampleView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _exampleView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor skyColor];
        _topView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [_topView addSubview:self.exampleView];
        
        [_topView addConstraint:[NSLayoutConstraint constraintWithItem:self.exampleView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        [_topView addConstraint:[NSLayoutConstraint constraintWithItem:self.exampleView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.topView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        
        [_topView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|->=0-[_exampleView]->=0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_exampleView)]];
        [_topView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|->=0-[_exampleView]->=0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_exampleView)]];
    }
    return _topView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.translatesAutoresizingMaskIntoConstraints = NO;
        _bottomView.backgroundColor = [UIColor spindriftColor];
        
        UIButton *intrinsicButton = [self.class buttonWithTarget:self title:@"V:|[label][label]|" viewType:EMViewTypeDefault];
        [_bottomView addSubview:intrinsicButton];
        
        UIButton *paddingButton = [self.class buttonWithTarget:self title:@"V:|[spacerOne][label][label][spacerTwo(==spacerOne)]|" viewType:EMViewTypePaddingExample];
        [_bottomView addSubview:paddingButton];
    
        UIButton *containerButton = [self.class buttonWithTarget:self title:@"Invisible Container" viewType:EMViewTypeContainerExample];
        [_bottomView addSubview:containerButton];
        
        
        UIButton *frameButton = [self.class buttonWithTarget:self title:@"Set Frame" viewType:EMViewTypeFrameExample];
        [_bottomView addSubview:frameButton];
        
        UIButton *optionsButton = [self.class buttonWithTarget:self title:@"NSLayoutFormatAlign" viewType:EMViewTypeOptionsExample];
        [_bottomView addSubview:optionsButton];
        
        UIButton *maskButton = [self.class buttonWithTarget:self title:@"Autoresizing Mask" viewType:EMViewTypeMaskExample];
        [_bottomView addSubview:maskButton];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(intrinsicButton, paddingButton, containerButton, frameButton, optionsButton, maskButton);
        
        [_bottomView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[intrinsicButton][paddingButton(==intrinsicButton)][containerButton(==intrinsicButton)]|" options: NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom metrics:nil views:views]];
        
        [_bottomView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[frameButton][optionsButton(==frameButton)][maskButton(==frameButton)]|" options:NSLayoutFormatAlignAllBottom | NSLayoutFormatAlignAllTop metrics:nil views:views]];
        
        [_bottomView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[intrinsicButton][frameButton(==intrinsicButton)]|" options:0 metrics:nil views:views]];
    }
    return _bottomView;
}

+ (UIButton *)buttonWithTarget:(id)target title:(NSString *)title viewType:(EMViewType)viewType {
    UIButton *button = [[UIButton alloc] init];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button addTarget:target action:@selector(toggleViewType:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.numberOfLines = 0;
    button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    button.tag = viewType;
    return button;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];
    
    id topLayoutGuide = self.topLayoutGuide;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topLayoutGuide][_topView][_bottomView(200)]|" options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight metrics:nil views:NSDictionaryOfVariableBindings(_topView, _bottomView, topLayoutGuide)]];
       [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_topView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_topView, _bottomView)]];

    [self.view setNeedsUpdateConstraints];
}

- (void)toggleViewType:(UIButton *)sender {
    if (sender.tag == EMViewTypeFrameExample) {
        if (CGRectEqualToRect(self.view.bounds, [UIScreen mainScreen].bounds)) {
            self.exampleView.viewType = 0;
            self.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame) / 2., CGRectGetHeight(self.view.frame) / 2.);
        } else {
            self.view.frame = [UIScreen mainScreen].bounds;
        }
        return;
    }
    
    self.exampleView.viewType = sender.tag;
}

@end
