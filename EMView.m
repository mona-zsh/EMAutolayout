//
//  EMView.m
//  EMAutolayout
//
//  Created by Mona Zhang on 10/27/15.
//  Copyright © 2015 Eskimona. All rights reserved.
//

#import "EMLabel.h"
#import "UIColor+EMColor.h"

#import "EMView.h"

@interface EMView ()

@property (nonatomic) EMLabel *topLabel;
@property (nonatomic) UILabel *bottomLabel;
@property (nonatomic) UILabel *middleLabel;

@property (nonatomic) NSMutableArray *visualFormatStrings;

@end

@implementation EMView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.topLabel = [[EMLabel alloc] init];
        self.topLabel .text = @"Top Label";
        self.topLabel .translatesAutoresizingMaskIntoConstraints = NO;
        BOX(self.topLabel );
        
        
        self.middleLabel = [[UILabel alloc] init];
        self.middleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.middleLabel.text = @"Middle Label";
        BOX(self.middleLabel);
        
        self.bottomLabel = [[UILabel alloc] init];
        self.bottomLabel .text = @"Bottom Label";
        self.bottomLabel .translatesAutoresizingMaskIntoConstraints = NO;
        BOX( self.bottomLabel );
        
        
        self.backgroundColor = [UIColor mercuryColor];
    }
    return self;
}

- (void)setViewType:(EMViewType)viewType {
    _viewType = viewType;
    if (self.constraints) {
        [self removeConstraints:self.constraints];
    }
    
    self.topLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.bottomLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.topLabel];
    [self addSubview:self.bottomLabel];
    
    switch (viewType) {
            
        case EMViewTypeDefault: {
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_topLabel]|" options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight metrics:nil views:NSDictionaryOfVariableBindings(_topLabel, _bottomLabel)]];
            
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_topLabel][_bottomLabel]|" options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight metrics:nil views:NSDictionaryOfVariableBindings(_topLabel, _bottomLabel)]];
            
            
            break;
        } case EMViewTypePaddingExample: {
            
            UIView *spacerOne = [[UIView alloc] init];
            spacerOne.translatesAutoresizingMaskIntoConstraints = NO;
            
            UIView *spacerTwo = [[UIView alloc] init];
            spacerTwo.translatesAutoresizingMaskIntoConstraints = NO;
            
            [self addSubview:spacerOne];
            [self addSubview:spacerTwo];
            
            BOX(spacerOne);
            BOX(spacerTwo);
            
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_topLabel]|" options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight metrics:nil views:NSDictionaryOfVariableBindings(_topLabel)]];
            
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[spacerOne(>=5)][_topLabel][_bottomLabel(==_topLabel)][spacerTwo(==spacerOne)]|" options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight metrics:nil views:NSDictionaryOfVariableBindings(_topLabel, _bottomLabel, spacerOne, spacerTwo)]];
            
            break;
        } case EMViewTypeContainerExample: {
            UIView *containerView = [[UIView alloc] init];
            containerView.translatesAutoresizingMaskIntoConstraints = NO;
            
            [containerView addSubview:self.topLabel];
            [containerView addSubview:self.bottomLabel];
            
            containerView.backgroundColor = [UIColor carnationColor];
            
            [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_topLabel]|" options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight metrics:nil views:NSDictionaryOfVariableBindings(_topLabel, _bottomLabel)]];
            
            [containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_topLabel][_bottomLabel]|" options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight metrics:nil views:NSDictionaryOfVariableBindings(_topLabel, _bottomLabel)]];
            
            [self addSubview:containerView];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:containerView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|->=0-[containerView]->=0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(containerView)]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|->=0-[containerView]->=0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(containerView)]];
            
            break;
        } case EMViewTypeFrameExample: {
            break;
        } case EMViewTypeOptionsExample: {
            [self addSubview:self.middleLabel];
            
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_topLabel]|" options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight metrics:nil views:NSDictionaryOfVariableBindings(_topLabel, _bottomLabel)]];
            
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_topLabel]->=0-[_bottomLabel]|" options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight metrics:nil views:NSDictionaryOfVariableBindings(_topLabel, _bottomLabel)]];
            
            
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_topLabel][_middleLabel][_bottomLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_topLabel, _bottomLabel, _middleLabel)]];
            
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-15-[_middleLabel]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_middleLabel)]];
            
            break;
            
        } case EMViewTypeMaskExample: {
            self.topLabel.translatesAutoresizingMaskIntoConstraints = YES;
            self.bottomLabel.translatesAutoresizingMaskIntoConstraints = YES;
            
            self.topLabel.bounds = self.bounds;
            self.bottomLabel.bounds = self.bounds;
            
            self.topLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            self.bottomLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            
            [self setNeedsLayout];
            [self layoutIfNeeded];
            break;
            
        } default: {
            break;
        }
    }
    
    [self setNeedsUpdateConstraints];
}

@end
