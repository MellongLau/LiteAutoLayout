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
    
    /// Set layout constraints between two views
    ///
    /// - parameter left:  the subview, or the view is at the right or bottom.
    /// - parameter right: the superview, or the view is at the top or left.
    ///
    /// - returns: RelationLiteAutoLayout instance
    public static func ~> (left: UIView, right: UIView) -> RelationLiteAutoLayout {
        return RelationLiteAutoLayout(left: left, right: right)
    }
    
    
    /// Set view's layout attribute
    ///
    /// - parameter left: which view's layout constraints to be set
    ///
    /// - returns: ItemLiteAutoLayout instance
    public static prefix func ~> (view: UIView) -> ItemLiteAutoLayout {
        return ItemLiteAutoLayout(left: view, right: nil)
    }
    
    
    /// Set the view's layout attribute
    ///
    /// - returns: ItemLiteAutoLayout instance
    public func startLayout() -> ItemLiteAutoLayout {
        return ItemLiteAutoLayout(left: self, right: nil)
    }
    
    
    /// Set layout constraints between two views
    ///
    /// - parameter toView: the view's superview, or at the top or left of the view.
    ///
    /// - returns: RelationLiteAutoLayout instance
    public func startLayout(toView: UIView) -> RelationLiteAutoLayout {
        return RelationLiteAutoLayout(left: self, right: toView)
    }
    
}

fileprivate enum ContraintType
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

fileprivate class ContraintModel
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
    
    init(contraintType: ContraintType, constants: Float, relatedBy: (Int, Int) -> Bool, multiplier: Float, priority: UILayoutPriority) {
        self.multiplier = multiplier
        self.priority = priority
        self.type = contraintType
        self.constant = constants
        self.relatedBy = checkOperator(relatedBy)
    }
    
    private func checkOperator(_ test: (Int, Int) -> Bool) -> NSLayoutRelation{
        let lessThan = test(0, 1)
        let equal = test(0, 0)
        let greaterThan = test(1, 0)
        
        let lessThanOrEqual = lessThan && equal
        let greaterThanOrEqual = greaterThan && equal
        
        if greaterThanOrEqual {
            return .greaterThanOrEqual
        }
        
        if lessThanOrEqual {
            return .lessThanOrEqual
        }
        
        assert(!lessThan, "Only <=, >= and == operators allow!")
        assert(!greaterThan, "Only <=, >= and == operators allow!")
        
        return .equal
    }
    
}

public class ItemLiteAutoLayout: LiteAutoLayout {
    
    @discardableResult public func marginTop(_ constant: Float = 0, relatedBy: ((Int, Int) -> Bool) = (==), multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> ItemLiteAutoLayout {
        let item = ContraintModel(contraintType: .top, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        secondItem = firstItem.superview
        addContraint(contraintModel: item)
        secondItem = nil
        return self
    }
    
    @discardableResult public func marginBottom(_ constant: Float = 0, relatedBy: ((Int, Int) -> Bool) = (==), multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> ItemLiteAutoLayout {
        let item = ContraintModel(contraintType: .bottom, constants: -constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        secondItem = firstItem.superview
        addContraint(contraintModel: item)
        secondItem = nil
        return self
    }
    
    @discardableResult public func marginLeft(_ constant: Float = 0, relatedBy: ((Int, Int) -> Bool) = (==), multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> ItemLiteAutoLayout {
        let item = ContraintModel(contraintType: .leading, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        secondItem = firstItem.superview
        addContraint(contraintModel: item)
        secondItem = nil
        return self
    }
    
    @discardableResult public func marginRight(_ constant: Float = 0, relatedBy: ((Int, Int) -> Bool) = (==), multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> ItemLiteAutoLayout {
        let item = ContraintModel(contraintType: .trailing, constants: -constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        secondItem = firstItem.superview
        addContraint(contraintModel: item)
        secondItem = nil
        return self
    }
    
    @discardableResult public func height(_ constant: Float = 0, relatedBy: ((Int, Int) -> Bool) = (==), multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> ItemLiteAutoLayout {
        let item = ContraintModel(contraintType: .equalHeights, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult public func width(_ constant: Float = 0, relatedBy: ((Int, Int) -> Bool) = (==), multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> ItemLiteAutoLayout {
        let item = ContraintModel(contraintType: .equalWidths, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    
    
    @discardableResult public func centerVertically(_ constant: Float = 0, relatedBy: ((Int, Int) -> Bool) = (==), multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> ItemLiteAutoLayout {
        let item = ContraintModel(contraintType: .centerVertically, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        secondItem = firstItem.superview
        addContraint(contraintModel: item)
        secondItem = nil
        return self
    }
    
    @discardableResult public func centerHorizontally(_ constant: Float = 0, relatedBy: ((Int, Int) -> Bool) = (==), multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> ItemLiteAutoLayout {
        let item = ContraintModel(contraintType: .centerHorizontally, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        secondItem = firstItem.superview
        addContraint(contraintModel: item)
        secondItem = nil
        return self
    }
    
    @discardableResult public func aspectRatio(width: Float, height: Float, relatedBy: ((Int, Int) -> Bool) = (==), priority: Float = UILayoutPriorityRequired) -> ItemLiteAutoLayout {
        let item = ContraintModel(contraintType: .aspectRatio, constants: 0, relatedBy: relatedBy, multiplier: width/height, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
}

public class RelationLiteAutoLayout: LiteAutoLayout {
    @discardableResult public func baseline(_ constant: Float = 0, relatedBy: ((Int, Int) -> Bool) = (==), multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> RelationLiteAutoLayout {
        guard let _ = secondItem else {
            return self
        }
        
        let item = ContraintModel(contraintType: .baseline, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult public func leading(_ constant: Float = 0, relatedBy: ((Int, Int) -> Bool) = (==), multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> RelationLiteAutoLayout {
        guard let _ = secondItem else {
            return self
        }
        
        let item = ContraintModel(contraintType: .leading, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult public func bottom(_ constant: Float = 0, relatedBy: ((Int, Int) -> Bool) = (==), multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> RelationLiteAutoLayout {
        guard let _ = secondItem else {
            return self
        }
        
        let item = ContraintModel(contraintType: .bottom, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult public func top(_ constant: Float = 0, relatedBy: ((Int, Int) -> Bool) = (==), multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> RelationLiteAutoLayout {
        guard let _ = secondItem else {
            return self
        }
        
        let item = ContraintModel(contraintType: .top, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult public func trailing(_ constant: Float = 0, relatedBy: ((Int, Int) -> Bool) = (==), multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> RelationLiteAutoLayout {
        guard let _ = secondItem else {
            return self
        }
        
        let item = ContraintModel(contraintType: .trailing, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult public func horizontalSpacing(_ constant: Float = 0, relatedBy: ((Int, Int) -> Bool) = (==), multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> RelationLiteAutoLayout {
        guard let _ = secondItem else {
            return self
        }
        
        let item = ContraintModel(contraintType: .horizontalSpacing, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult public func verticalSpacing(_ constant: Float = 0, relatedBy: ((Int, Int) -> Bool) = (==), multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> RelationLiteAutoLayout {
        guard let _ = secondItem else {
            return self
        }
        
        let item = ContraintModel(contraintType: .verticalSpacing, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult public func equalHeights(_ constant: Float = 0, relatedBy: ((Int, Int) -> Bool) = (==), multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> RelationLiteAutoLayout {
        let item = ContraintModel(contraintType: .equalHeights, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult public func equalWidths(_ constant: Float = 0, relatedBy: ((Int, Int) -> Bool) = (==), multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> RelationLiteAutoLayout {
        let item = ContraintModel(contraintType: .equalWidths, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    
    
    @discardableResult public func centerVertically(_ constant: Float = 0, relatedBy: ((Int, Int) -> Bool) = (==), multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> RelationLiteAutoLayout {
        let item = ContraintModel(contraintType: .centerVertically, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult public func centerHorizontally(_ constant: Float = 0, relatedBy: ((Int, Int) -> Bool) = (==), multiplier: Float = 1.0, priority: Float = UILayoutPriorityRequired) -> RelationLiteAutoLayout {
        let item = ContraintModel(contraintType: .centerHorizontally, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
}

public class LiteAutoLayout {
    
    fileprivate var constraints: [ContraintModel] = []
    fileprivate var firstItem: UIView!
    fileprivate var secondItem: UIView?
    
    public init(left: UIView, right: UIView?) {
        left.translatesAutoresizingMaskIntoConstraints = false
        firstItem = left
        secondItem = right
    }
    
    
    
    fileprivate func addContraint(contraintModel: ContraintModel) -> Void {
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

