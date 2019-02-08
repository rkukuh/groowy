//
//  UITextViewWithPlaceholder.swift
//  Groowy
//
//  Created by David-UC on 2/8/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit

class UITextViewWithPlaceholder: UITextView, UITextViewDelegate {
    
    var customDelegate:UITextViewWithPlaceholderDelegate?
    @IBOutlet weak var placeholderTextView:UITextView!
    
    override func didMoveToSuperview() {
        self.delegate = self
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text != "" {
            hidePlaceholder()
        } else {
            showPlaceholder()
        }
        customDelegate?.textViewDidChange(text: textView.text)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        customDelegate?.textViewDidEndEditing(text: textView.text)
    }
    
    func showPlaceholder() {
        UIView.animate(withDuration: 0.5, animations: {
            self.placeholderTextView.alpha = 1
        }, completion: nil)
    }
    func hidePlaceholder() {
        UIView.animate(withDuration: 0.5, animations: {
            self.placeholderTextView.alpha = 0
        }, completion: nil)
    }

}
