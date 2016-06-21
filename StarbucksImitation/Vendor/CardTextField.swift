//
//  CardTextField.swift
//  StarbucksImitation
//
//  Created by lh on 16/6/21.
//  Copyright © 2016年 codwam. All rights reserved.
//

import UIKit

final class CardTextField: UITextField {
    
    var whiteSpaceInsertCount = 4
    var limitCardsCount = 20

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.constructView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.constructView()
    }
    
    func constructView() {
        self.keyboardType = .NumberPad
        self.delegate = self
    }

}

extension CardTextField: UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard var text = textField.text else {
            return true
        }
        
        text = (text as NSString).stringByReplacingCharactersInRange(range, withString: string)
        text = text.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        var newString = ""
        while text.length > 0 {
            let subString = (text as NSString).substringToIndex(min(text.length, self.whiteSpaceInsertCount))
            newString += subString
            if subString.length == self.whiteSpaceInsertCount {
                newString += " "
            }
            text = (text as NSString).substringFromIndex(min(text.length, self.whiteSpaceInsertCount))
        }

        let characterSet = NSCharacterSet(charactersInString: "0123456789\\b")
        newString = newString.stringByTrimmingCharactersInSet(characterSet.invertedSet)

        if newString.length >= self.limitCardsCount {
            return false
        }

        textField.text = newString
        
        return false
    }
    
}
