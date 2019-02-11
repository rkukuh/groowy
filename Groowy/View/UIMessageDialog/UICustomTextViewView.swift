//
//  UICustomTextViewView.swift
//  Groowy
//
//  Created by Jaya Pranata on 2/8/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit

class UICustomTextViewView: UIView {
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet var mainView: UIView!
    
    func startAnimationSelf(){
        UIView.animate(withDuration: 1.0, delay: 1.0, options: [.repeat, .autoreverse], animations: {
            self.frame = CGRect(x: self.frame.minX, y: 5 , width: self.frame.width, height: self.frame.height)
            
        }, completion: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit(){
        Bundle.main.loadNibNamed("UICustomTextView", owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = self.bounds
        mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
