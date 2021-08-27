//
//  NSTextFieldExtension.swift
//  SvijaSync
//
//  Created by Rajesh Ramachandrakurup on 10/2/21.
//

import Cocoa

extension NSTextField {

    var text: String? {
        let _text = stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        if _text.isEmpty { return nil }
        return _text
    }
    
}
