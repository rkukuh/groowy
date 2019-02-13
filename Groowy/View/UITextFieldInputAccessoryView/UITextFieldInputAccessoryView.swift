//
//  UITextFieldInputAccessoryView.swift
//  Groowy
//
//  Created by David-UC on 2/7/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit

class UITextFieldInputAccessoryView: UIView {

    var delegate:UITextFieldInputAccessoryViewDelegate?
    @IBOutlet weak var textField:UITextField!
    
    override func didMoveToSuperview() {
        textField.autocorrectionType = .no
        textField.becomeFirstResponder()
    }
    
    @IBAction func didTapSendButton(sender:UIButton) {
        if let delegate = delegate {
            delegate.didTapSendButton()
        }
    }
    
    override func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }

}
