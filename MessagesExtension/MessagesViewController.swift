//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Stanley Pan on 30/12/2016.
//  Copyright © 2016 Stanley Pan. All rights reserved.
//

import UIKit
import Messages

// Will use pickerview
class MessagesViewController: MSMessagesAppViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var introPicker: UIPickerView = UIPickerView()
    var dummyArray = ["dr-mundo", "ezreal", "shen", "thresh", "vayne"]
    var startButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Deal with compression and recognition of app screen as an app drawer
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.initialSetup), userInfo: nil, repeats: false)
    }
    
    func initialSetup() {
        addIntroPicker()
        addStartButton()
    }
    
    func addIntroPicker() {
        introPicker.delegate = self
        introPicker.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width / 2, height: self.view.bounds.height)
        self.view.addSubview(introPicker)
        introPicker.backgroundColor = .clear
    }
    
    func addStartButton() {
        startButton = UIButton(type: .custom)
        startButton.frame = CGRect(x: (self.view.bounds.width / 2) + 20, y: self.view.bounds.height / 2, width: (self.view.bounds.width / 2) - 40, height: 30)
        startButton.addTarget(self, action: #selector(self.pressedStart), for: .touchUpInside)
        startButton.setTitle("Caption This", for: .normal)
        startButton.titleLabel?.adjustsFontSizeToFitWidth = true
        startButton.titleLabel?.font = UIFont(name: "Arial", size: 20)
        startButton.setTitleColor(.black, for: .normal)
        startButton.backgroundColor = .yellow
        
        startButton.layer.borderWidth = 2.0
        startButton.layer.borderColor = (UIColor.black).cgColor
        startButton.layer.masksToBounds = false
        startButton.layer.shadowRadius = 5.0
        startButton.layer.shadowOpacity = 0.3
        startButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        startButton.layer.shadowColor = (UIColor.black).cgColor
        
        self.view.insertSubview(startButton, aboveSubview: introPicker)
    }
    
    func pressedStart() {
        
    }
    
    // MARK: PickerView delegate and datasource methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dummyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        if pickerView == introPicker {
            return 100
        } else {
            return 100
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return self.view.bounds.width / 2
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
//        let labelView = UILabel()
//        labelView.text = dummyArray[row]
//        labelView.adjustsFontSizeToFitWidth = true
//        labelView.font = UIFont(name: "Arial", size: 20)
//        labelView.textAlignment = .center
//        
//        return labelView
        
        let imageName: String = dummyArray[row] + ".png"
        let stickerImageView = UIImageView(image: UIImage(named: imageName))
        stickerImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        return stickerImageView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(dummyArray[row])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        // Use this method to configure the extension and restore previously stored state.
    }
    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }
   
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
    
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
    
        // Use this method to prepare for the change in presentation style.
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
    
        // Use this method to finalize any behaviors associated with the change in presentation style.
        if presentationStyle == .compact {
            repositionForCompact()
        } else if presentationStyle == .expanded {
            repositionForExpanded()
        }
    }
    
    func repositionForCompact() {
        UIView.animate(withDuration: 1, animations: {
            self.introPicker.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width / 2, height: self.view.bounds.height)
            
            self.startButton.frame = CGRect(x: (self.view.bounds.width / 2) + 20, y: self.view.bounds.height / 2, width: (self.view.bounds.width / 2) - 40, height: 30)
        })
    }
    
    func repositionForExpanded() {
        UIView.animate(withDuration: 1, animations: {
            self.introPicker.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width / 2, height: self.view.bounds.height)
            
            self.startButton.frame = CGRect(x: (self.view.bounds.width / 2) + 20, y: self.view.bounds.height / 2, width: (self.view.bounds.width / 2) - 40, height: 30)
        })
    }
}

















