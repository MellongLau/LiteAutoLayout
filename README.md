## LiteAutoLayout

<p align="left">

<img src="https://img.shields.io/badge/platform-Xcode%208%2B-blue.svg?style=flat" alt="Platform: Xcode 8+"/>
<img src="http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat" alt="License: MIT" />

</p>

### What is LiteAutoLayout

`LiteAutoLayout ` is developed with Swift 3.0, it is a simple and useful library for you to create layout constraint for the views. 

### Requirements

* Swift 3.0, Xcode 8+
* iOS 7.0 or later

### How to Install

Download `LiteAutoLayout.swift` to your project folder, and then add reference to your project.

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
(view2 ~> view1).equalHeights(relatedBy: .greaterThanOrEqual, multiplier: 1/2)
```

## More
Learn more? Follow my `WeChat` public account `mellong`:

![WeChat QRcode](http://www.devlong.com/blogImages/qrcode_for_mellong.jpg)

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
