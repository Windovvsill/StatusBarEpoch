//
//  TimeStampViewController.swift
//  Time Stamp
//
//  Created by Steve on 2020-04-01.
//  Copyright © 2020 Steve. All rights reserved.
//

import Cocoa

class TimeStampViewController: NSViewController, NSTextFieldDelegate {
    
    // This number is 1975 when interpreted in ms and year 6976 in seconds
    let timeScaleThreshold = 158000000000.0

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var outputLabel: NSTextField!
    @IBOutlet weak var errorLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do view setup here.
        textField.delegate = self
        
        // Show something in the textfield and output on boot
        writeNowInTextField()
    }
    
    @objc func textFieldDidChange(_ textField: NSTextField) {

    }
    
    public func controlTextDidEndEditing(_ obj: Notification) {
        renderOutput()
    }
    
    public func controlTextDidChange(_ obj: Notification) {
        renderOutput()
    }
    
    func renderOutput() {
        // Check the identifier to be sure you have the correct textfield if more are used
//        if let textField = obj.object as? NSTextField, self.textField.identifier == textField.identifier {
            
            let (scaledTs, timeUnitDescriptionString) = tsScaleFormat(ts: textField.doubleValue)
            
            let date = Date(timeIntervalSince1970: scaledTs)
            let dateFormatter = DateFormatter()
            
            // Use the machine timezeon and set the date formatting
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss O"
            let strDate = dateFormatter.string(from: date)
            
            errorLabel.stringValue = timeUnitDescriptionString
            outputLabel.stringValue = strDate
//        }
    }
    
    /**
     * Determine whether to interpret the input as milliseconds or seconds
     * and returns the scaled timestamp and the unit descriptor.
     */
    func tsScaleFormat(ts: Double) -> (Double, String) {
        if (ts > timeScaleThreshold) {
            return (ts / 1000, "milliseconds")
        } else {
            return (ts, "seconds")
        }
    }
    
    func writeTsInTextField(ts: Double) {
        textField.stringValue = String(format: "%.0f", (ts).rounded())
        renderOutput()
    }
    
    func writeNowInTextField() {
        writeTsInTextField(ts: NSDate().timeIntervalSince1970)
    }
}

extension TimeStampViewController {
    @IBAction func now(_ sender: NSButton) {
        writeNowInTextField()
    }
}

extension TimeStampViewController {
  // MARK: Storyboard instantiation
  static func freshController() -> TimeStampViewController {
    
    let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
    
    let identifier = NSStoryboard.SceneIdentifier("TimeStampViewController")
    
    guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? TimeStampViewController else {
      fatalError("Cannot find TimeStampViewController, check Main.storyboard")
    }
    
    return viewcontroller
  }
}




