//
//  UIViewController.swift
//  Groowy
//
//  Created by David-UC on 2/7/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit

extension UIViewController {
    var prefersStatusBarHidden: Bool {
        return true
    }
    
    func loadViewFromNib(nibName:String) -> UIView? {
        if let views =  Bundle.main.loadNibNamed(nibName, owner: nil, options: nil) {
            if let view = views.first as? UIView {
                return view
            }
        }
        print("Error in loadViewFromNib \(nibName)")
        return nil
    }
    
}
