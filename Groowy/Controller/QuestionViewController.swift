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
        
        if currentDialog.current?.answers == nil {
            bottomView.bottomButton.isHidden = true
            bottomView.topButton.isHidden = true
        }

        updateDialog()
    }
    
    @objc func actionButtonBottom(_sender: UIButton){
        currentDialog.nextState(answerIndex: 1)
        
        if currentDialog.current?.answers == nil {
            bottomView.bottomButton.isHidden = true
            bottomView.topButton.isHidden = true
        }

        updateDialog()
    }
    
    // MARK: - Private functions
    
    private func loadDialogData() {
        deepUnderstandingDialog.category = "Deep Understanding dialog"
        
        let dialogs = [
            Dialog("Apakah kamu siap menerima tantangan di Akademi ini?"),
            Dialog("Kenapa? Apakah kamu bermaksud menghindari tantangan?"),
            Dialog("Tapi kamu mau mencoba kan?"),
            Dialog("Great! Memang seharusnya kita hadapi tantangan dan tidak mudah menyerah kan?"),
            Dialog("Why? How do you see an effort as?"),
            Dialog("Tidakkah kamu ingin berhasil dan sukses? Bukankah itu memerlukan usaha?"),
            Dialog("Kalo ga berusaha gimana bisa sukses?"),
            Dialog("Aku kasih masukan buat kebaikanmu sih... Belajarlah menerima kritik itu seperti jamu"),
            Dialog("Great! It's the right mind that you have"),
        ]
        
        deepUnderstandingDialog.dialogs.append(contentsOf: dialogs)
        
        deepUnderstandingDialog.dialogs[0].answers.append(DialogAnswer("Tentu", then: deepUnderstandingDialog.dialogs[2]))
        deepUnderstandingDialog.dialogs[0].answers.append(DialogAnswer("Kurang yakin", then: deepUnderstandingDialog.dialogs[1]))
        
        deepUnderstandingDialog.dialogs[1].answers.append(DialogAnswer("Tidak", then: deepUnderstandingDialog.dialogs[3]))
        deepUnderstandingDialog.dialogs[1].answers.append(DialogAnswer("Ya", then: deepUnderstandingDialog.dialogs[2]))
        
        deepUnderstandingDialog.dialogs[2].answers.append(DialogAnswer("Ya", then: deepUnderstandingDialog.dialogs[3]))
        deepUnderstandingDialog.dialogs[2].answers.append(DialogAnswer("I'll Try", then: deepUnderstandingDialog.dialogs[3]))
        
        deepUnderstandingDialog.dialogs[3].answers.append(DialogAnswer("Sure", then: deepUnderstandingDialog.dialogs[8]))
        deepUnderstandingDialog.dialogs[3].answers.append(DialogAnswer("Not sure", then: deepUnderstandingDialog.dialogs[4]))
        
        deepUnderstandingDialog.dialogs[4].answers.append(DialogAnswer("The path to mastery", then: deepUnderstandingDialog.dialogs[8]))
        deepUnderstandingDialog.dialogs[4].answers.append(DialogAnswer("Fruitless", then: deepUnderstandingDialog.dialogs[5]))
        
        deepUnderstandingDialog.dialogs[5].answers.append(DialogAnswer("Ok, sure", then: deepUnderstandingDialog.dialogs[8]))
        deepUnderstandingDialog.dialogs[5].answers.append(DialogAnswer("Not really", then: deepUnderstandingDialog.dialogs[6]))
        
        deepUnderstandingDialog.dialogs[6].answers.append(DialogAnswer("You are right. I got it", then: deepUnderstandingDialog.dialogs[8]))
        deepUnderstandingDialog.dialogs[6].answers.append(DialogAnswer("Still no...", then: deepUnderstandingDialog.dialogs[7]))
        
        deepUnderstandingDialog.dialogs[7].answers.append(DialogAnswer("You are right. I got it", then: deepUnderstandingDialog.dialogs[8]))
        deepUnderstandingDialog.dialogs[7].answers.append(DialogAnswer("Yeah, I guess I got your point", then: deepUnderstandingDialog.dialogs[8]))
        
        deepUnderstandingDialog.dialogs[8].answers.append(DialogAnswer("", then: nil))
        deepUnderstandingDialog.dialogs[8].answers.append(DialogAnswer("", then: nil))
        
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
