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

struct UIViewBorderOptions : OptionSet {
    let rawValue: Int
    
    static let top  = UIViewBorderOptions(rawValue: 1 << 0)
    static let left = UIViewBorderOptions(rawValue: 1 << 1)
    static let right  = UIViewBorderOptions(rawValue: 1 << 2)
    static let bottom  = UIViewBorderOptions(rawValue: 1 << 3)
    
    static let all: UIViewBorderOptions = [.top, .right, .bottom, .left]
    
}

let UIViewBorderTag = -7239

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    func setBorder(width: Float, color: UIColor) {
        layer.borderColor = color.cgColor
        layer.borderWidth = CGFloat(width)
    }
    
    func setCorner(radius: Float) {
        layer.cornerRadius = CGFloat(radius)
    }
    
    func showBorder(width: Float, color: UIColor, position: UIViewBorderOptions) {
        
        removeBorder()
        
        if UIViewBorderOptions.all == position {
            setBorder(width: width, color: color)
            return;
        }
        
        let createBorderView = {(color: UIColor) -> UIView in
            let borderView = UIView()
            borderView.backgroundColor = color
            borderView.tag = UIViewBorderTag
            self.addSubview(borderView)
            return borderView
        }
        
        if position.contains(.top) {
            let borderView = createBorderView(color)
            (~>borderView).height(width).marginLeft().marginRight().marginTop()
        }
        
        if position.contains(.bottom) {
            let borderView = createBorderView(color)
            (~>borderView).height(width).marginRight().marginLeft().marginBottom()
        }
        
        if position.contains(.left) {
            let borderView = createBorderView(color)
            (~>borderView).width(width).marginLeft().marginTop().marginBottom()
        }
        
        if position.contains(.right) {
            let borderView = createBorderView(color)
            (~>borderView).width(width).marginRight().marginTop().marginBottom()
        }
    }
    
    func removeBorder() {
        for item in subviews {
            if item.tag == UIViewBorderTag {
                item.removeFromSuperview()
                
            }
        }
    }
}


extension UIButton {
    func setTitleForNormal(_ title: String?) {
        setTitle(title, for: .normal)
    }
    
    func setTitleColorForNormal(_ color: UIColor?) {
        setTitleColor(color, for: .normal)
    }
    
    func setImageForNormal(image: UIImage?) {
        setImage(image, for: .normal)
    }
    
    func setBackgroundImageForNormal(image: UIImage?) {
        setBackgroundImage(image, for: .normal)
    }
    
    func addTargetForTouchUpInside(_ target: Any?, action: Selector) {
        addTarget(target, action: action, for: .touchUpInside)
    }
}

extension UIViewController  {
    
    func showOKMessage(_ title: String, message: String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction) in
            
        })
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }
    
    func showConfirmMessage(_ title: String, message: String, confirmHandler: ((UIAlertAction) -> Void)?, cancelHandler: ((UIAlertAction) -> Void)?)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let confirm = UIAlertAction(title: NSLocalizedString("Confirm", comment: ""), style: UIAlertActionStyle.default, handler: confirmHandler)
        alertController.addAction(confirm)
        let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: UIAlertActionStyle.cancel, handler: cancelHandler)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showConfirmMessage(_ title: String, message: String, confirmHandler:((UIAlertAction) -> Void)?)
    {
        showConfirmMessage(title, message: message, confirmHandler: confirmHandler, cancelHandler: nil)
    }
}
