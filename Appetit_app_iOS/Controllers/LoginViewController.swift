//
//  LoginViewController.swift
//  Appetit_app_iOS
//
//  Created by Marcos Joshoa on 12/12/19.
//  Copyright © 2019 Marcos Joshoa. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbPassword: UILabel!
    @IBOutlet weak var btEyePswd: UIButton!
    @IBOutlet weak var btLogin: UIButton!
    
    private var loggedUser: User?
    
    // MARK: - Controllers functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
        self.initObservers()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    deinit {
        Utils.setKeyboardDenitsNotifications()
    }
    
    // MARK: - Handle keyboard when it's in front of tfPassword
       private func initObservers() {
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIWindow.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIWindow.keyboardWillHideNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIWindow.keyboardWillChangeFrameNotification, object: nil)
       }
       
       @objc func keyboardWillChange(notification: Notification) {
           if tfPassword.isFirstResponder {
               guard let keyboardRect = (notification.userInfo?[UIWindow.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                   return
               }
               if notification.name == UIWindow.keyboardWillShowNotification || notification.name == UIWindow.keyboardWillChangeFrameNotification {
                   self.view.frame.origin.y = -keyboardRect.height + btLogin.frame.height + tfPassword.frame.height
               } else {
                   self.view.frame.origin.y = 0
               }
           } else if notification.name == UIWindow.keyboardWillHideNotification {
               self.view.frame.origin.y = 0
           }
       }
    
    // MARK: - UITextFieldDelegate functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfEmail {
            tfPassword.becomeFirstResponder()
        } else if textField == tfPassword {
            view.endEditing(true)
        }
        return true
    }
    
    // MARK: - Views configure functions
    private func initViews() {
        setTfsPadding()
        configTfEmail()
        configTfPswd()
        configBtLogin()
    }
    
    private func setTfsPadding() {
        tfEmail.setLeftPadding(15)
        tfPassword.setLeftPadding(15)
    }
    
    private func tfsSetBorder(_ tf: UITextField, width: CGFloat = 1, color: UIColor = UIColor.lightGray) {
        tf.borderWidth = width
        tf.borderColor = color
    }
    
    private func setBtEyePswdState() {
        if tfPassword.isSecureTextEntry {
            btEyePswd.setImage(#imageLiteral(resourceName: "eye_close"), for: .normal)
        } else {
            btEyePswd.setImage(#imageLiteral(resourceName: "eye_open"), for: .normal)
        }
    }
    
    private func showPassword() {
        tfPassword.isSecureTextEntry.toggle()
        setBtEyePswdState()
    }
    
    private func handleTopLbsTfs(label: UILabel, textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            label.textColor = UIColor(named: "dark_color")
            label.isHidden = false
        } else {
            label.textColor = UIColor(named: "main_color")
            label.isHidden = true
        }
    }
    
    private func configBtLogin() {
        btLogin.cornerRadius = 28
    }
    
    private func configTfEmail() {
        tfEmail.delegate = self
        tfEmail.cornerRadius = 6
        tfsSetBorder(tfEmail)
        tfEmail.addTarget(self, action: #selector(highlightTfEmail), for: .allEvents)
    }
    
    private func configTfPswd() {
        tfPassword.delegate = self
        tfPassword.cornerRadius = 6
        btEyePswd.isEnabled = false
        tfsSetBorder(tfPassword)
        setBtEyePswdState()
        tfPassword.addTarget(self, action: #selector(highlightTfPswd), for: .allEvents)
    }
    
    @objc
    private func highlightTfEmail() {
        if tfEmail.isFirstResponder {
            lbEmail.textColor = UIColor(named: "main_color")
            tfsSetBorder(tfEmail, width: 2.5, color: UIColor(named: "main_color")!)
            lbEmail.isHidden = false
        } else {
            tfsSetBorder(tfEmail)
            handleTopLbsTfs(label: lbEmail, textField: tfEmail)
        }
    }
    
    @objc
    private func highlightTfPswd() {
        if tfPassword.isFirstResponder {
            lbPassword.textColor = UIColor(named: "main_color")
            tfsSetBorder(tfPassword, width: 2.5, color: UIColor(named: "main_color")!)
            btEyePswd.isEnabled = true
            lbPassword.isHidden = false
        } else {
            tfsSetBorder(tfPassword)
            btEyePswd.isEnabled = false
            handleTopLbsTfs(label: lbPassword, textField: tfPassword)
        }
    }
    
    // MARK: - Login functions
    private func goToListOrders() {
        if let navigationVC = self.storyboard?.instantiateViewController(withIdentifier: Strings.navigationControllerId), let vc = self.storyboard?.instantiateViewController(withIdentifier: Strings.listOrdersViewId) {
            let listOrdersVC = vc as! ListOrdersViewController
            listOrdersVC.setUser(loggedUser!)
            let navVC = navigationVC as! UINavigationController
            navVC.viewControllers = [listOrdersVC]
            self.show(navigationVC, sender: self)
        }
    }
    
    private func login() {
        if let email = tfEmail.text, !email.isEmpty {
            if  let pswd = tfPassword.text, !pswd.isEmpty {
                RestfulWebService.logingWS(context: context, login: email, password: pswd) { user in
                    self.loggedUser = user
                    if self.loggedUser != nil {
                        self.goToListOrders()
                    }
                }
            } else {
                // TODO: show msg in toast
                print("Empty password.")
            }
        } else {
            // TODO: show msg in toast
            print("Empty email.")
        }
    }
    
    // MARK: - Actions functions
    @IBAction func loginAction(_ sender: UIButton) {
        login()
    }
    
    @IBAction func showPasswordAction(_ sender: UIButton) {
        showPassword()
    }
}
