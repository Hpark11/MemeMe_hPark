//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by connect on 2017. 1. 18..
//  Copyright © 2017년 boostcamp. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController {

    var activityButton:UIButton?
    @IBOutlet weak var imagePickedByUserView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var topMemeTextField: CustomMemeTextField!
    @IBOutlet weak var bottomMemeTextField: CustomMemeTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarUI()
        
        setTextFieldAttribute(key: KEY_TEXT_FIELD_TOP)
        setTextFieldAttribute(key: KEY_TEXT_FIELD_BOTTOM)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    func setNavigationBarUI() {
        let logo = UIImage(named: "Meme Home Logo")
        let logoImageView = UIImageView(image: logo)
        self.navigationItem.titleView = logoImageView
        
        activityButton = UIButton(type: .custom)
        activityButton?.setImage(UIImage(named: "icon upload"), for: .normal)
        activityButton?.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        activityButton?.addTarget(self, action: #selector(self.activityButtonTapped), for: .touchUpInside)
        activityButton?.isEnabled = false
        if let activityBtn = activityButton {
            let activityButtonItem = UIBarButtonItem(customView: activityBtn)
            self.navigationItem.rightBarButtonItem = activityButtonItem
        }
    }
    
    func setTextFieldAttribute(key: String) {
        if key == KEY_TEXT_FIELD_TOP {
            self.topMemeTextField.text = key
            self.topMemeTextField.delegate = self
        } else if key == KEY_TEXT_FIELD_BOTTOM {
            self.bottomMemeTextField.text = key
            self.bottomMemeTextField.delegate = self
        }
    }
    
    // get keyboard height and shift the view from bottom to higher
    func keyboardWillShow(_ notification: Notification) {
        if bottomMemeTextField.isFirstResponder {
            view.frame.origin.y = 64 - getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        if bottomMemeTextField.isFirstResponder {
            view.frame.origin.y = 64
        }
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    
    func activityButtonTapped() {
        print("activityButton Tapped")
    }
    
    @IBAction func albumButtonTapped(_ sender: Any) {
        presentImagePickerController(.photoLibrary)
    }
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        presentImagePickerController(.camera)
    }
    
    
    
}
