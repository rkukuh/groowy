//
//  QuestionViewController.swift
//  Groowy
//
//  Created by Jaya Pranata on 2/8/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var currentDialog = DialogState()
    var textFieldInput: UICustomTextViewView?
    var deepUnderstandingDialog = DialogRule()
    
    @IBOutlet weak var bottomView: UIAnswerBodyView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldInput = UICustomTextViewView(view: view)
        
        loadDialogData()
        setupCurrentDialog()
        
        bottomView.topButton.addTarget(self, action: #selector(actionButtonTop), for: .touchUpInside)
        bottomView.bottomButton.addTarget(self, action: #selector(actionButtonBottom), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textFieldInput!.startAnimationSelf()
    }
    
    // MARK: - Action buttons
    
    @objc func actionButtonTop(_sender: UIButton){
        currentDialog.nextState(answerIndex: 0)
        
        updateDialog()
    }
    
    @objc func actionButtonBottom(_sender: UIButton){
        currentDialog.nextState(answerIndex: 1)
        
        updateDialog()
    }
    
    // MARK: - Private functions
    
    private func loadDialogData() {
        deepUnderstandingDialog.category = "Deep Understanding dialog"
        
        let dialogs = [
            Dialog("Apakah kamu siap menerima tantangan di Akademi ini?"),
            Dialog("Kenapa? Apakah kamu bermaksud menghindari tantangan?"),
            Dialog("Great! Memang seharusnya kita hadapi tantangan dan tidak mudah menyerah kan?")
        ]
        
        deepUnderstandingDialog.dialogs.append(contentsOf: dialogs)
        
        deepUnderstandingDialog.dialogs[0].answers.append(DialogAnswer("Tentu", then: deepUnderstandingDialog.dialogs[2]))
        deepUnderstandingDialog.dialogs[0].answers.append(DialogAnswer("Kurang yakin", then: deepUnderstandingDialog.dialogs[1]))
        
        deepUnderstandingDialog.dialogs[1].answers.append(DialogAnswer("Tidak", then: deepUnderstandingDialog.dialogs[2]))
        deepUnderstandingDialog.dialogs[1].answers.append(DialogAnswer("Ya", then: deepUnderstandingDialog.dialogs[1]))
        
        deepUnderstandingDialog.dialogs[2].answers.append(DialogAnswer("Sure", then: nil))
        deepUnderstandingDialog.dialogs[2].answers.append(DialogAnswer("Not sure", then: nil))
        
        currentDialog.current = deepUnderstandingDialog.dialogs[0]
        currentDialog.history = []
    }
    
    private func setupCurrentDialog() {
        currentDialog.current = deepUnderstandingDialog.dialogs[0]
        
        updateDialog()
    }
    
    private func updateDialog() {
        if let currentDialog = currentDialog.current {
            if let myText = textFieldInput {
                view.addSubview(myText)
                
                textFieldInput!.messageTextView.text = currentDialog.text
            }
            
            if currentDialog.answers.count > 0 {
                bottomView.topButton.setTitle(currentDialog.answers[0].text, for: .normal)
            }
            
            if currentDialog.answers.count > 1 {
                bottomView.bottomButton.setTitle(currentDialog.answers[1].text, for: .normal)
            }
        }
    }
}
