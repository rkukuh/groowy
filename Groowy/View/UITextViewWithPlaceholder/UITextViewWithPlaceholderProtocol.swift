//
//  UITextViewWithPlaceholderProtocol.swift
//  Groowy
//
//  Created by David-UC on 2/8/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit

protocol UITextViewWithPlaceholderDelegate {
    
    func textViewDidChange(text:String)
    func textViewDidEndEditing(text:String)
}
