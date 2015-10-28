# EMAutolayout

## Overview
This is a test app to demonstrate autolayout magicks. Please read the [full document](https://docs.google.com/document/d/1qVPtrmkXEAZXFCyYvLb1IU7HZY0Jm1H9evbbC2C527E/edit?usp=sharing) for autolayout tips and tricks.

There are six demo modes:

    EMViewTypeDefault,          // two labels vertically aligned
    EMViewTypePaddingExample,   // two labels vertically aligned with padding
    EMViewTypeContainerExample, // two labels centered in a container view with padding on container view
    EMViewTypeFrameExample,     // demonstrates that constraints keep relationships the same between views
    EMViewTypeOptionsExample,   // three labels with different alignment options
    EMViewTypeMaskExample,      // labels that use autoresizingMask

You can see how the layout constraints are set up [here](https://github.com/mona-zsh/EMAutolayout/blob/master/EMView.m).

## Set up

1. git clone https://github.com/mona-zsh/EMAutolayout.git
1. Open project in XCode
1. Build
1. Press buttons
1. Pressing `Set Frame` button will toggle the frame to half size/full size.

