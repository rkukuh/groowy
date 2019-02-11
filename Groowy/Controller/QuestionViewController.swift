//
//  QuestionViewController.swift
//  Groowy
//
//  Created by Jaya Pranata on 2/8/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    var textFieldInput:UICustomTextViewView?
    
    @IBOutlet weak var bottomView: UIAnswerBodyView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldInput = UICustomTextViewView(frame: CGRect(x: 0, y: 0,
                                                            width: self.view.frame.width,
                                                            height: self.view.frame.height * 0.3))
        
        if let myText = textFieldInput {
            self.view.addSubview(myText)
            
            textFieldInput!.messageTextView.text = "Tes isi via code"
        }
        
        bottomView.topButton.setTitle("atas", for: .normal)
        bottomView.bottomButton.setTitle("bawah", for: .normal)

        
        bottomView.topButton.addTarget(self, action: #selector(actionButtonTop), for: .touchUpInside)
        bottomView.bottomButton.addTarget(self, action: #selector(actionButtonBottom), for: .touchUpInside)
    }
    
    @objc func actionButtonTop(_sender: UIButton){
        print("atas")
    }
    
    @objc func actionButtonBottom(_sender: UIButton){
        print("bawah")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textFieldInput!.startAnimationSelf()
    }
}
