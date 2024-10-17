
## LiteAutoLayout

<p align="left">

<img src="https://img.shields.io/badge/platform-Xcode%2015%2B-blue.svg?style=flat" alt="Platform: Xcode 15+"/>
<img src="http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat" alt="License: MIT" />

</p>

*Like this project?*  `Star us above!`

### What is LiteAutoLayout

`LiteAutoLayout ` is developed with Swift 5.0, it is a simple and useful library for you to create layout constraint for the views. 

### Language

[中文](./README_CN.md)

### Demo

Below screenshot show the demo screenshot of the library.

![Demo](./screenshot.png)

All the LiteAutoLayout style contraints code show below:

![Code](./layout_contraints.png)

### NSLayoutConstraint vs NSLayoutAnchor vs LiteAutoLayout

Such as setting the vertical distance between the two views: `verticalSpacing()`, it is worth noting that the view on the right of `~>` is the top side of the view, if it is to add a horizontal distance, then the view on the right of `~>` is on the left side.

This library is a simple wrapper, and if you have used sdk to create a constraint, you should be intimidated by its cumbersome wording.

Here is an official example of the Apple:

```swift
// Using NSLayoutConstraint create layout constraint
NSLayoutConstraint(item: subview,
                   attribute: .Leading,
                   relatedBy: .Equal,
                   toItem: view,
                   attribute: .LeadingMargin,
                   multiplier: 1.0,
                   constant: 0.0).active = true
 
NSLayoutConstraint(item: subview,
                   attribute: .Trailing,
                   relatedBy: .Equal,
                   toItem: view,
                   attribute: .TrailingMargin,
                   multiplier: 1.0,
                   constant: 0.0).active = true
``` 

```swift
// Using Layout Anchors create the same layout constraint
let margins = view.layoutMarginsGuide
 
subview.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
subview.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
```

The first example use NSLayoutConstraint to create a simple layout constraints need complicated code, the second example use NSLayoutAnchor can simplify the constraint code, but still need three lines code, let's use LiteAutoLayout to create the same layout constraints:

```swift
// Using Lite Auto Layout create the same layout constraint
(subview ~> view).leading().trailing()
```

We only need one line code to create the same layout constraints!

### Requirements

* Swift 5.0
* iOS 12.0 or later

### How to Install

Download `LiteAutoLayout.swift` to your project folder, and then add reference to your project.

or use CocoaPods.

### CocoaPods

[CocoaPods](http://www.cocoapods.org) is the recommended way to add LiteAutoLayout to your project.

1. Add additional entry to your Podfile.

  ```ruby
  pod "LiteAutoLayout", "~> 1.0.1"
  ```

2. Install  Pod(s) running `pod install` command.
3. Include AMAnimatedNumber using `import LiteAutoLayout`.

### How to use

For example:

`panel` is superview which contain subview `view1` and `view2`.

Set layout constraint between `view1` and `view2`:

```swift

(view1 ~> panel).top(20).leading()
(view2 ~> view1).horizontalSpacing(5).equalHeights().top()
(view2 ~> panel).trailing()

```

`view1` have 20pt margin top and 0pt left margin.

`view1` is in the left of `view2`, and there are 5pt horizontal space between `view1` and `view2`, they have the same height and top margin.

`view2` have 0pt bottom margin in panel.

Above code is similar with the Interface Builder, if you have experience in create autolayout constraint with interface builder, you will easy to use LiteAutoLayout.


You can set `view1` width and height with 300pt like below:

```swift
(~>view1).equalWidths(300).equalHeights(300)
```

or you can set `view2` height >= 1/2 `view1` height:

```swift
(view2 ~> view1).equalHeights(relatedBy: >=, multiplier: 1/2)
```

### Using LiteAutoLayout?

If you're using LiteAutoLayout in one of your own projects, let me know! I'll add a link to your profile/website/app right here on the front page. Feel free to email me at the address shown below.

A Germany developer has used our library in his app:

![Meine Erste Wahl](http://is1.mzstatic.com/image/thumb/Purple127/v4/ea/da/b1/eadab136-b1f0-4bfb-6f01-2791f12ddaa6/source/175x175bb.jpg)

[Meine Erste Wahl](https://itunes.apple.com/us/app/meine-erste-wahl-bundestag-2017-wahl-helfer/id1201796437?ls=1&mt=8)

### Contributing
Forks, patches and other feedback are welcome.

### Creator
I'm Mellong, you can contact me by E-Mail: <tendencystudio@gmail.com>


## License

MIT License

Copyright (c) 2016 Mellong Lau

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
