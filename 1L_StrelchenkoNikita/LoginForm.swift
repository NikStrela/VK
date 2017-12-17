//
//  LoginForm.swift
//  1L_StrelchenkoNikita
//
//  Created by Никита on 15.09.17.
//  Copyright © 2017 Никита. All rights reserved.
//

import UIKit
import Alamofire

class LoginForm: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginView: UITextField!
    @IBOutlet weak var passwordView: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                                            
        //жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        //присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //Подписываемся на два уведомления, одно приходит при появляении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        // Второе когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    
    //когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        
        //получем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
        
        //Добавляем отсуп внизу UIScrollView равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        //устанавливаем отступ внизу UIScrollView равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
      
        
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    @IBAction func pressIn(_ sender: Any) {
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "afterLogin" {
            let checkResult = checkUserData()
            
            if !checkResult {
                showLoginError()
            }
            return checkResult
        } else {
            return true
        }
        
        
    }
    
    func checkUserData() -> Bool {
        
        let login = loginView.text!
        
        let password = passwordView.text!
        
        if login == "" && password == "" {
            return true
        } else {
            return false
        }
        
    }
    
    
    func showLoginError() {
        
        let alert = UIAlertController(title: "Fatal(.)(.)Error", message: "Incorrect login or password try again please", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
   

}
