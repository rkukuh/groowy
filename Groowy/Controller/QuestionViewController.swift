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
    @IBAction func answerButton1(_ sender: UIButton) {
        print("hallo")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldInput = UICustomTextViewView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 0.3))
        if let myText = textFieldInput{
            self.view.addSubview(myText)
        }
        

        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textFieldInput!.startAnimationSelf()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
