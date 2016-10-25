//
//  LiteAutoLayout.swift
//
//
//  Created by Mellong Lau on 10/14/16.
//  Copyright © 2016 Mellong Lau. All rights reserved.
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
    /// - returns: LiteAutoLayout object
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
    /// - returns: LiteAutoLayout object
    func startLayout() -> LiteAutoLayout {
        let lite = LiteAutoLayout(left: self, right: nil)
        return lite
    }
    
    
    /// Set two views layout layout constraints
    ///
    /// - parameter toView: superview, top or left position view.
    ///
    /// - returns: LiteAutoLayout object
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
    
    @discardableResult func setEqualHeights(_ constant: Float) -> LiteAutoLayout {
        return setEqualHeights(constant: constant, relatedBy: .equal, multiplier: 1.0, priority: UILayoutPriorityRequired)
    }
    
    @discardableResult func setEqualWidths(_ constant: Float) -> LiteAutoLayout {
        return setEqualWidths(constant: constant, relatedBy: .equal, multiplier: 1.0, priority: UILayoutPriorityRequired)
    }
    
    @discardableResult func setBaseline(_ constant: Float) -> LiteAutoLayout {
        return setBaseline(constant: constant, relatedBy: .equal, multiplier: 1.0, priority: UILayoutPriorityRequired)
    }
    
    @discardableResult func setLeading(_ constant: Float) -> LiteAutoLayout {
        return setLeading(constant: constant, relatedBy: .equal, multiplier: 1.0, priority: UILayoutPriorityRequired)
    }
    
    @discardableResult func setBottom(_ constant: Float) -> LiteAutoLayout {
        return setBottom(constant: constant, relatedBy: .equal, multiplier: 1.0, priority: UILayoutPriorityRequired)
    }
    
    @discardableResult func setTop(_ constant: Float) -> LiteAutoLayout {
        return setTop(constant: constant, relatedBy: .equal, multiplier: 1.0, priority: UILayoutPriorityRequired)
    }

    @discardableResult func setTrailing(_ constant: Float) -> LiteAutoLayout {
        return setTrailing(constant: constant, relatedBy: .equal, multiplier: 1.0, priority: UILayoutPriorityRequired)
    }
    
    @discardableResult func setHorizontalSpacing(_ constant: Float) -> LiteAutoLayout {
        return setHorizontalSpacing(constant: constant, relatedBy: .equal, multiplier: 1.0, priority: UILayoutPriorityRequired)
    }
    
    @discardableResult func setVerticalSpacing(_ constant: Float) -> LiteAutoLayout {
        return setVerticalSpacing(constant: constant, relatedBy: .equal, multiplier: 1.0, priority: UILayoutPriorityRequired)
    }
    
    @discardableResult func setCenterVertically(_ constant: Float) -> LiteAutoLayout {
        return setCenterVertically(constant: constant, relatedBy: .equal, multiplier: 1.0, priority: UILayoutPriorityRequired)
    }
    
    @discardableResult func setCenterHorizontally(_ constant: Float) -> LiteAutoLayout {
        return setCenterHorizontally(constant: constant, relatedBy: .equal, multiplier: 1.0, priority: UILayoutPriorityRequired)
    }
    
    @discardableResult func setAspectRatio(width: Float, height: Float) -> LiteAutoLayout {
        return setAspectRatio(width: width, height: height, relatedBy: .equal, priority: UILayoutPriorityRequired)
    }
    
    @discardableResult func setEqualHeights(constant: Float, relatedBy: NSLayoutRelation, multiplier: Float, priority: Float) -> LiteAutoLayout {
        let item = ContraintModel(contraintType: .equalHeights, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult func setEqualWidths(constant: Float, relatedBy: NSLayoutRelation, multiplier: Float, priority: Float) -> LiteAutoLayout {
        let item = ContraintModel(contraintType: .equalWidths, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult func setBaseline(constant: Float, relatedBy: NSLayoutRelation, multiplier: Float, priority: Float) -> LiteAutoLayout {
        let item = ContraintModel(contraintType: .baseline, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult func setLeading(constant: Float, relatedBy: NSLayoutRelation, multiplier: Float, priority: Float) -> LiteAutoLayout {
        let item = ContraintModel(contraintType: .leading, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult func setBottom(constant: Float, relatedBy: NSLayoutRelation, multiplier: Float, priority: Float) -> LiteAutoLayout {
        let item = ContraintModel(contraintType: .bottom, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult func setTop(constant: Float, relatedBy: NSLayoutRelation, multiplier: Float, priority: Float) -> LiteAutoLayout {
        let item = ContraintModel(contraintType: .top, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult func setTrailing(constant: Float, relatedBy: NSLayoutRelation, multiplier: Float, priority: Float) -> LiteAutoLayout {
        let item = ContraintModel(contraintType: .trailing, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult func setHorizontalSpacing(constant: Float, relatedBy: NSLayoutRelation, multiplier: Float, priority: Float) -> LiteAutoLayout {
        let item = ContraintModel(contraintType: .horizontalSpacing, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult func setVerticalSpacing(constant: Float, relatedBy: NSLayoutRelation, multiplier: Float, priority: Float) -> LiteAutoLayout {
        let item = ContraintModel(contraintType: .verticalSpacing, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult func setCenterVertically(constant: Float, relatedBy: NSLayoutRelation, multiplier: Float, priority: Float) -> LiteAutoLayout {
        let item = ContraintModel(contraintType: .centerVertically, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult func setCenterHorizontally(constant: Float, relatedBy: NSLayoutRelation, multiplier: Float, priority: Float) -> LiteAutoLayout {
        let item = ContraintModel(contraintType: .centerHorizontally, constants: constant, relatedBy: relatedBy, multiplier: multiplier, priority: priority)
        constraints.append(item)
        addContraint(contraintModel: item)
        return self
    }
    
    @discardableResult func setAspectRatio(width: Float, height: Float, relatedBy: NSLayoutRelation, priority: Float) -> LiteAutoLayout {
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

