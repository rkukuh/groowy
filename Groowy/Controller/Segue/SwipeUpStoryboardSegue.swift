//
//  SwipeUpStoryboardSegue.swift
//  SwipeSheetViewController
//
//  Created by David-UC on 2/7/19.
//  Copyright © 2019 David-UC. All rights reserved.
//

import UIKit

class SwipeUpStoryboardSegue: UIStoryboardSegue {
    
    override func perform() {
        let firstView = self.source.view as UIView
        let secondView = self.destination.view as UIView
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        secondView.frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: screenHeight)
        
        if let secondViewHolder = self.destination as? SwipeFormViewController {
            secondViewHolder.previousVC = self.source
        } else {
            fatalError("The previous View Controller has been not inherit from SwipeFormViewController")
        }
        
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(secondView, aboveSubview: firstView)
        print(screenHeight)
        UIView.animate(withDuration: 1.5, animations: {
            firstView.frame.origin.y -= screenHeight
            secondView.frame.origin.y -= screenHeight
            
        }) { (Finished) in
            self.source.present(self.destination, animated: false, completion: nil)
        }
    }
    
    
    
}
