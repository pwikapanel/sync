//
//  CustomButton.swift
//  SvijaSync
//
//  Created by Rajesh Ramachandrakurup on 7/11/2023.
//

import Cocoa

class CustomButton: NSButton {
	override var focusRingType: NSFocusRingType {
		get { .none }
		set { }
	}

	override func becomeFirstResponder() -> Bool {
		let success = super.becomeFirstResponder()
		if success {
			self.bezelColor = .systemBlue
			// Set the blue background color when the button becomes the first responder
		}
		return success
	}

	override func resignFirstResponder() -> Bool {
		let success = super.resignFirstResponder()
		if success {
			// Reset the background color when the button resigns the first responder status
			self.bezelColor = nil
		}
		return success
	}
}
