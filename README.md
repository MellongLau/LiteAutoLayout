## LiteAutoLayout

### What is LiteAutoLayout

`LiteAutoLayout ` is developed with Swift 3.0, it is a simple and useful library for you to create layout constraint for the views. 

### Requirements

* Swift 3.0, Xcode 8

* iOS 7.0 or later

### How to Install



### How to use

`panel` is superview which contain subview `view1` and `view2`.

Set layout constraint between `view1` and `view2`:

```swift

(view1 ~> panel).setTop(20).setLeading(0)
(view2 ~> view1).setHorizontalSpacing(5).setEqualHeights(0).setTop(0)
(view2 ~> panel).setTrailing(0)

```

`view1` have 20pt margin top and 0pt left margin.

`view1` is in the left of `view2`, and there are 5pt horizontal space between `view1` and `view2`, they have the same height and top margin.

`view2` have 0pt bottom margin in panel.

Above code is similar with the Interface Builder, if you have experience in create autolayout constraint with interface builder, you will easy to use LiteAutoLayout.


You can set `view1` width and height with 300pt like below:

```swift
 (~>view1).setEqualWidths(300).setEqualHeights(300)
```

