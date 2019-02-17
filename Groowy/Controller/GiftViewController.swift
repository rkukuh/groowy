//
//  GiftViewController.swift
//  Groowy
//
//  Created by Jaya Pranata on 2/10/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit
import SpriteKit
import MessageUI

class GiftViewController: UIViewController, MFMailComposeViewControllerDelegate, UIGiftViewDelegate, UITextFieldInputAccessoryViewDelegate {
    
    
    
    func clickedBoxGift(text: String) {
        // MARK: - JAYA Email Message
//        print("halo")
//        let mail = MFMailComposeViewController()
//        mail.mailComposeDelegate = self
//        mail.setToRecipients(["you@yoursite.com"])
//        mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
//        if MFMailComposeViewController.canSendMail() {
//            present(mail,animated: true, completion: nil)
//            //present(mail, animated: true)
//        } else {
//        }
        // MARK: - JAYA Email Message
        
        showKeyboardWithTextFieldAccessoryView()
        
    }
    
    var textFieldInput: UITextFieldInputAccessoryView?
    var bubbleChat: UICustomTextViewView?
    let textField = UITextField(frame: CGRect(x: 0, y: -50, width: 100, height: 50))
    var giftBox: UIGiftView?
    var scene: GameScene!
    var timer:Timer!
    
    
    @IBOutlet weak var spriteKit: SKView!
    @IBOutlet weak var handBottomView: UIView!
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "dashboard") as! DashboardViewController
        self.present(newViewController, animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHiddenTextField()
        
        // Add Gamescene to View Controller
        scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .resizeFill
        spriteKit.ignoresSiblingOrder = true
        spriteKit.presentScene(scene)
        bubbleChat = UICustomTextViewView(view: view)
        bubbleChat?.messageTextView.text = "I'll give you a link of resources. It would nice if you want to check on it, tap the gift box!"
        giftBox = UIGiftView(view: view)
        
        if let myGift = giftBox {
            myGift.customDelegate = self
            view.addSubview(myGift)
            view.bringSubviewToFront(handBottomView)
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func setupHiddenTextField() {
        // Add textfield outside of view
        view.addSubview(textField)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        giftBox!.startAnimationSelf()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6, execute: {
            if let myText = self.bubbleChat {
                self.view.addSubview(myText)
                myText.startAnimationSelf()
            }
        })
        
        GroowieSound.changeBackSound(sound: .smile)
        GroowieSound.startBackSound()
        GroowieSound.startSoundEffect()
        
        //textFieldInput!.startAnimationSelf()
        scene.groowyCharacter.changeGroowyAnimateState(nextState: .wake)
    }

    // MARK: - DAVID
    func showKeyboardWithTextFieldAccessoryView() {
        if let textFieldInput = loadViewFromNib(nibName: "UITextFieldInputAccessory") as? UITextFieldInputAccessoryView {
            self.textFieldInput = textFieldInput
            
            textField.autocorrectionType = .no
            textFieldInput.textField.autocapitalizationType = .none
            textFieldInput.textField.keyboardType = .emailAddress
            textField.inputAccessoryView = textFieldInput
            
            textField.becomeFirstResponder()
            
            textFieldInput.delegate = self
            
            bubbleChat?.messageTextView.text = "What's your email? I'll send it to your mail"
        }
    }
    
    // MARK: - UITextFieldInputAccessoryViewDelegate
    func didTapSendButton() {
        // Dismiss keyboard, need to refine
        if let textFieldInput = textFieldInput {
            let email = textFieldInput.textField.text
            User.email = email ?? ""
            
            textFieldInput.resignFirstResponder()
            view.endEditing(true)
            
            // prepare json data
            let json: [String: Any] = ["username": "jaya","email": email ?? "","link":"www.google.com",
                                       "dict": ["1":"First", "2":"Second"]]
            
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            
            // create post request
            let url = URL(string: "http://glorious-institution.com/restGroowie/rest_controller.php/email")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            // insert json data to the request
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON)
                }
            }
            
            task.resume()
            
            bubbleChat?.messageTextView.text = "Nice! Already send it!"
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "dashboard") as! DashboardViewController
            self.present(newViewController, animated: false, completion: nil)
            
            
            
        }
        
        
    }
    // MARK: - DAVID

}
