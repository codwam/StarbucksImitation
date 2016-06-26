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
    private let trimmingCharacterSet = NSCharacterSet(charactersInString: "0123456789\\b")

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
        
        let startIndex = text.startIndex.advancedBy(range.location)
        let endIndex = startIndex.advancedBy(range.length)
        let textRange = Range(startIndex..<endIndex)
        text = text.stringByReplacingCharactersInRange(textRange, withString: string)
        text = text.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        var newString = ""
        while text.characters.count > 0 {
            let subIndex = min(text.endIndex, text.startIndex.advancedBy(self.whiteSpaceInsertCount, limit: text.endIndex))
            let subString = text.substringToIndex(subIndex)
            newString += subString
            if subString.characters.count == self.whiteSpaceInsertCount {
                newString += " "
            }
            text = text.substringFromIndex(subIndex)
        }

        newString = newString.stringByTrimmingCharactersInSet(self.trimmingCharacterSet.invertedSet)

        if text.characters.count >= self.limitCardsCount {
            return false
        }

        textField.text = newString
        
        return false
    }
    
}
