//
//  UITextFieldInputAccessoryView.swift
//  Groowy
//
//  Created by David-UC on 2/7/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit

class UITextViewInputAccessoryView: UIView {
    
    var delegate:UITextViewInputAccessoryViewDelegate?
    @IBOutlet weak var textView:UITextView!
    
    override func didMoveToSuperview() {
        textView.autocorrectionType = .no
        textView.becomeFirstResponder()
    }
    
    @IBAction func didTapSendButton(sender:UIButton) {
        if let delegate = delegate {
            delegate.didTapSendButton()
        }
    }
    
    override func resignFirstResponder() -> Bool {
        return textView.resignFirstResponder()
    }
    
    func clear() {
        textView.text = ""
        if let textViewWithPlaceholder = textView as? UITextViewWithPlaceholder {
            textViewWithPlaceholder.clear()
        }
    }
}
