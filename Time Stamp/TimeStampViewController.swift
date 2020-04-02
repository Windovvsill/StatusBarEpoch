//
//  TimeStampViewController.swift
//  Time Stamp
//
//  Created by Steve on 2020-04-01.
//  Copyright © 2020 Steve. All rights reserved.
//

import Cocoa

class TimeStampViewController: NSViewController, NSTextFieldDelegate {

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var outputLabel: NSTextField!
    @IBOutlet weak var errorLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        textField.delegate = self
    }
    
    @objc func textFieldDidChange(_ textField: NSTextField) {

    }
    
    public func controlTextDidEndEditing(_ obj: Notification) {
        renderOutput(obj: obj)
    }
    
    public func controlTextDidChange(_ obj: Notification) {
        renderOutput(obj: obj)
    }
    
    func renderOutput(obj: Notification) {
        // check the identifier to be sure you have the correct textfield if more are used
        if let textField = obj.object as? NSTextField, self.textField.identifier == textField.identifier {
            print("\n\nMy own textField = \(String(describing: self.textField))\nNotification textfield = \(textField)")
            print("\nChanged text = \(textField.stringValue)\n")
            
            let ts: Double
            if (textField.doubleValue > 1580000000000) {
                ts = textField.doubleValue / 1000
                errorLabel.stringValue = "Note: assuming format is milliseconds"
            } else {
                ts = textField.doubleValue
                errorLabel.stringValue = ""
            }
            
            
            let date = Date(timeIntervalSince1970: ts)
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone.current // Use the machine timezone
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss O" //Specify your format that you want
            let strDate = dateFormatter.string(from: date)
            
            outputLabel.stringValue = strDate
        }
    }
}

extension TimeStampViewController {
    @IBAction func now(_ sender: NSButton) {
        textField.stringValue = String(format: "%.0f", (NSDate().timeIntervalSince1970).rounded())
    }
}

extension TimeStampViewController {
  // MARK: Storyboard instantiation
  static func freshController() -> TimeStampViewController {
    //1.
    let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
    //2.
    let identifier = NSStoryboard.SceneIdentifier("TimeStampViewController")
    //3.
    guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? TimeStampViewController else {
      fatalError("Why cant i find TimeStampViewController? - Check Main.storyboard")
    }
    return viewcontroller
  }
}




