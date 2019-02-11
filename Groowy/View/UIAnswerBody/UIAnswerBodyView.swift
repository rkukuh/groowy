//
//  UIAnswerBodyView.swift
//  Groowy
//
//  Created by Jaya Pranata on 2/11/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit

class UIAnswerBodyView: UIView {
    @IBOutlet weak var topButton: UIButton!
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var bottomButton: UIButton!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit(){
        Bundle.main.loadNibNamed("UIAnswerBody", owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = self.bounds
        mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
