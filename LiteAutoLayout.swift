//
// Copyright (c) 2016 Mellong Lau
// https://github.com/MellongLau/LiteAutoLayout
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//


import UIKit


// MARK: - Public API
prefix operator ~>

public extension UIView {
    
    /// Set two views layout layout constraints
    ///
    /// - parameter left:  subview, right or bottom position view.
    /// - parameter right: superview, top or left position view.
    ///
    /// - returns: LiteAutoLayout
    static func ~> (left: UIView, right: UIView) -> LiteAutoLayout {
        let lite = LiteAutoLayout(left: left, right: right)
        return lite
    }
    

    /// Set view's layout attribute
    ///
    /// - parameter left: which view to be set
    ///
    /// - returns: LiteAutoLayout object
    static prefix func ~> (view: UIView) -> LiteAutoLayout {
        let lite = LiteAutoLayout(left: view, right: nil)
        return lite
    }
    
    
    /// Set view's layout attribute
    ///
    /// - returns: LiteAutoLayout
    func startLayout() -> LiteAutoLayout {
        let lite = LiteAutoLayout(left: self, right: nil)
        return lite
    }
    
    
    /// Set two views layout layout constraints
    ///
    /// - parameter toView: superview, top or left position view.
    ///
    /// - returns: LiteAutoLayout
    func startLayout(toView: UIView) -> LiteAutoLayout {
        let lite = LiteAutoLayout(left: self, right: toView)
        return lite
    }
    
}

enum ContraintType
{
    case equalHeights
    case equalWidths
    case leading
    case trailing
    case baseline
    case aspectRatio
    case centerHorizontally
    case centerVertically
    case top
    case bottom
    case horizontalSpacing
    case verticalSpacing
}

class ContraintModel
{
    var type: ContraintType
    var constant: Float = 0.0
    var multiplier: Float = 1.0
    var priority: UILayoutPriority = UILayoutPriorityRequired
    var relatedBy: NSLayoutRelation = .equal
    
    init(contraintType: ContraintType, constants: Float) {
        self.type = contraintType
        self.constant = constants
    }
    
    init(contraintType: ContraintType, constants: Float, relatedBy: NSLayoutRelation, multiplier: Float, priority: UILayoutPriority) {
        self.multiplier = multiplier
        self.priority = priority
        self.type = contraintType
        self.constant = constants
        self.relatedBy = relatedBy
    }
}

public class LiteAutoLayout {
    var constraints: [ContraintModel] = []
    var firstItem: UIView!
    var secondItem: UIView?
    
    init(left: UIView, right: UIView?) {
        left.translatesAutoresizingMaskIntoConstraints = false
        firstItem = left
        secondItem = right
    }
    
    
    @discardableResult func equalHeights(_ constant: Float = 0, relatedBy: NSLayoutRelation = .equal, multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> LiteAutoLayout {
        let item = ContraintModel(contraintType: .equalHeights, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult func equalWidths(_ constant: Float = 0, relatedBy: NSLayoutRelation = .equal, multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> LiteAutoLayout {
        let item = ContraintModel(contraintType: .equalWidths, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult func baseline(_ constant: Float = 0, relatedBy: NSLayoutRelation = .equal, multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> LiteAutoLayout {
        guard let _ = secondItem else {
            return self
        }
        
        let item = ContraintModel(contraintType: .baseline, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult func leading(_ constant: Float = 0, relatedBy: NSLayoutRelation = .equal, multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> LiteAutoLayout {
        guard let _ = secondItem else {
            return self
        }
        
        let item = ContraintModel(contraintType: .leading, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult func bottom(_ constant: Float = 0, relatedBy: NSLayoutRelation = .equal, multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> LiteAutoLayout {
        guard let _ = secondItem else {
            return self
        }
        
        let item = ContraintModel(contraintType: .bottom, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult func top(_ constant: Float = 0, relatedBy: NSLayoutRelation = .equal, multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> LiteAutoLayout {
        guard let _ = secondItem else {
            return self
        }
        
        let item = ContraintModel(contraintType: .top, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult func trailing(_ constant: Float = 0, relatedBy: NSLayoutRelation = .equal, multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> LiteAutoLayout {
        guard let _ = secondItem else {
            return self
        }
        
        let item = ContraintModel(contraintType: .trailing, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult func horizontalSpacing(_ constant: Float = 0, relatedBy: NSLayoutRelation = .equal, multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> LiteAutoLayout {
        guard let _ = secondItem else {
            return self
        }
        
        let item = ContraintModel(contraintType: .horizontalSpacing, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult func verticalSpacing(_ constant: Float = 0, relatedBy: NSLayoutRelation = .equal, multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> LiteAutoLayout {
        guard let _ = secondItem else {
            return self
        }
        
        let item = ContraintModel(contraintType: .verticalSpacing, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult func centerVertically(_ constant: Float = 0, relatedBy: NSLayoutRelation = .equal, multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> LiteAutoLayout {
        let item = ContraintModel(contraintType: .centerVertically, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult func centerHorizontally(_ constant: Float = 0, relatedBy: NSLayoutRelation = .equal, multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> LiteAutoLayout {
        let item = ContraintModel(contraintType: .centerHorizontally, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult func aspectRatio(width: Float, height: Float, relatedBy: NSLayoutRelation = .equal, priority: Float = UILayoutPriorityRequired) -> LiteAutoLayout {
        let item = ContraintModel(contraintType: .aspectRatio, constants: 0, relatedBy: relatedBy, multiplier: width/height, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    
    private func addContraint(contraintModel: ContraintModel) -> Void {
        let item = contraintModel
        var layoutConstraint: NSLayoutConstraint!
        var layoutAttributes: (fistAttribute: NSLayoutAttribute, secondAttibute: NSLayoutAttribute)
        
        switch item.type {
        case .baseline:
            layoutAttributes = (.lastBaseline, .lastBaseline)
            
        case .bottom:
            layoutAttributes = (.bottom, .bottom)
            
        case .top:
            layoutAttributes = (.top, .top)
            
        case .centerVertically:
            layoutAttributes = (.centerY, .centerY)
            
        case .centerHorizontally:
            layoutAttributes = (.centerX, .centerX)
            
        case .equalHeights:
            layoutAttributes = (.height, .height)
            
        case .equalWidths:
            layoutAttributes = (.width, .width)
            
        case .leading:
            layoutAttributes = (.leading, .leading)
            
        case .trailing:
            layoutAttributes = (.trailing, .trailing)
        case .horizontalSpacing:
            layoutAttributes = (.leading, .trailing)
            
        case .verticalSpacing:
            layoutAttributes = (.top, .bottom)
            
        case .aspectRatio:
            layoutAttributes = (.width, .height)
            layoutConstraint = NSLayoutConstraint(item: firstItem,
                                                  attribute: .width,
                                                  relatedBy: item.relatedBy,
                                                  toItem: firstItem,
                                                  attribute: .height,
                                                  multiplier: CGFloat(item.multiplier),
                                                  constant: CGFloat(item.constant))
            
        }
        
        if item.type != .aspectRatio {
            layoutConstraint = NSLayoutConstraint(item: firstItem,
                                                  attribute: layoutAttributes.fistAttribute,
                                                  relatedBy: item.relatedBy,
                                                  toItem: secondItem,
                                                  attribute: layoutAttributes.secondAttibute,
                                                  multiplier: CGFloat(item.multiplier),
                                                  constant: CGFloat(item.constant))
        }
        
        layoutConstraint.priority = item.priority
        
        // if second item is nil, add constraint to the first item and return.
        guard let _ = secondItem else {
            firstItem.addConstraint(layoutConstraint)
            return;
        }
        
        // find the parent view to add layout constraint if exist.
        if firstItem === secondItem?.superview {
            firstItem.addConstraint(layoutConstraint)
        }else if firstItem.superview === secondItem {
            secondItem?.addConstraint(layoutConstraint)
        }else if firstItem.superview === secondItem?.superview {
            firstItem.superview?.addConstraint(layoutConstraint)
        }
        else {
            firstItem.addConstraint(layoutConstraint)
        }
        
    }
    
}

