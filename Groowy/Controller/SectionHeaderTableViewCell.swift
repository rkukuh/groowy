//
//  SectionHeaderTableViewCell.swift
//  Groowy
//
//  Created by Jaya Pranata on 2/15/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit

class SectionHeaderTableViewCell: UIView {
    var parentView: UIView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var arrowLabel: UILabel?
    var section: Int = 0
    weak var delegate: SectionHeaderTableViewCellDelegate?
    
    @IBAction func tapOnCell(_ sender: UITapGestureRecognizer) {
        print("sao")
        delegate?.toggleSection(header: self, section: section)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        //addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
    }
    @objc private func didTapHeader() {
        delegate?.toggleSection(header: self, section: section)
        print("helppppp")
    }
    
    init(view: UIView) {
        parentView = view
        let frame = CGRect(x: 0, y: view.frame.height , width: view.frame.width, height: view.frame.height * 0.5)
        super.init(frame: frame)
        commonInit()
    }
    
    //Set by program
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    //Set using storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("UITableHeaderCustom", owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = self.bounds
        mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}

protocol SectionHeaderTableViewCellDelegate: class {
    func toggleSection(header: SectionHeaderTableViewCell, section: Int)
}
