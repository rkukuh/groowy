//
//  UIViewNextQuestion.swift
//  Groowy
//
//  Created by David-UC on 2/13/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit

protocol UIViewNextQuestionDelegate {
    func didTapNextButton()
}

class UIViewNextQuestion: UIView {

    var delegate: UIViewNextQuestionDelegate?
    
    @IBAction func didTapNextButton(sender: UIButton) {
        delegate?.didTapNextButton()
    }

}
