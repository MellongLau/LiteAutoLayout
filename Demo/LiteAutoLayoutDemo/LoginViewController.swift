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

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "LiteAutoLayout Demo"

        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        // Do any additional setup after loading the view.
        
        // **************************************
        // *                                    *
        // *     Create UI item instances       *
        // *                                    *
        // **************************************
        
        let usernameLabel = UILabel()
        let passwordLabel = UILabel()
        let usernameTextField = CustomStyleTextField()
        let passwordTextField = CustomStyleTextField()
        let submitButton = UIButton(type: .system)
    
        view.addSubviews(usernameLabel, passwordLabel, usernameTextField, passwordTextField, submitButton)

        // Setup text fields.
        passwordTextField.flatStyle()
        usernameTextField.flatStyle()
        usernameTextField.placeholder = "Your username"
        passwordTextField.placeholder = "Your password"
        passwordTextField.isSecureTextEntry = true
        
        // Setup labels
        usernameLabel.text = "Username:"
        passwordLabel.text = "Password:"
        
        // Setup button.
        submitButton.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(LoginViewController.onSubmitButtonClicked(sender:)), for: .touchUpInside)
        

         
        // **************************************
        // *                                    *
        // *          Layout contraints         *
        // *                                    *
        // **************************************
        
        // Same layout contraints for the text field and label.
        (usernameTextField ~> usernameLabel).horizontalSpacing(10).equalHeights(20).baseline()
        (passwordTextField ~> passwordLabel).horizontalSpacing(10).equalHeights(20).baseline()
        
        // Set the margin for label and text field.
        (~>usernameLabel).marginTop(150).marginLeft(20)
        (~>usernameTextField).marginRight(20)
        
        // Compress label width if possible.
        usernameLabel.setContentHuggingPriority(UILayoutPriority.required, for: .horizontal)
        
        // Set two lable with same leading and trailing, and with 30pt vertiall spaces.
        (passwordLabel ~> usernameLabel).leading().trailing().verticalSpacing(30)
        
        // Setup submit button layout contraints.
        (~>submitButton).centerHorizontally().height(30)
        
        (submitButton ~> passwordLabel).verticalSpacing(100).leading()
        (submitButton ~> passwordTextField).trailing()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func onSubmitButtonClicked(sender: UIButton) {

        showOKMessage("Warning", message: "On submit button clicked!")
    }

}

class CustomStyleTextField: UITextField {
    func flatStyle() {
        showBorder(width: 1, color: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), position: .bottom)
    }
}


