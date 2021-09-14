//
//  Alert.swift
//  Food Delivery App
//
//  Created by Maheesha De Silva on 2021-09-12.
//

import Foundation
import UIKit

class Alert {
    
    /*
     
     HOW TO USE
     
     ------ No Buttons Alert ------
     
     Alert.init(title: "Test", msg: "test", vc: self).show({_ in
     
     })
     
     ------ Single Button Alert ------
     
     Alert.init(title: "Test", msg: "test", vc: self, bName: "button").show(completion:{
     (cliked_on) in
     print("Clicked on: \(cliked_on)")
     })
     
     
     ------ Single Button With Custom Style Alert ------
     
     Alert.init(title: "Test", msg: "test", vc: self, bName: "button", style: UIAlertControllerStyle.ActionSheet).show(completion:{
     (cliked_on) in
     print("Clicked on: \(cliked_on)")
     })
     
     ------ Two Buttons Alert ------
     
     Alert.init(title: "Test", msg: "test", vc: self, b1Name: "button1", b2Name: "button2").show(completion:{
     (cliked_on) in
     print("Clicked on: \(cliked_on)")
     })
     
     ------ Two Buttons With Custom Style Alert ------
     
     Alert.init(title: "Test", msg: "test", vc: self, b1Name: "button1", b2Name: "button2", style: UIAlertControllerStyle.ActionSheet).show(completion:{
     (cliked_on) in
     print("Clicked on: \(cliked_on)")
     })
     
     */
    
    //User define variables
    private var alert_type  : String = ""
    private var title       : String = ""
    private var msg         : String = ""
    private var vc          : UIViewController!
    private var b1          : String = ""
    private var b2          : String = ""
    private var style       : UIAlertController.Style = UIAlertController.Style.alert
    
    //Initialize alert message
    init(title: String, msg: String, vc:UIViewController){
        self.title = title
        self.msg = msg
        self.vc = vc
        
        alert_type = "no_button"
    }
    
    //Initialize alert message with single button
    init(title: String, msg: String, vc: UIViewController, bName: String){
        self.title = title
        self.msg = msg
        self.vc = vc
        self.b1 = bName
        
        alert_type = "single_button"
    }
    
    //Initialize alert message with two buttons
    init(title: String, msg: String, vc: UIViewController, b1Name: String, b2Name:String){
        self.title = title
        self.msg = msg
        self.vc = vc
        self.b1 = b1Name
        self.b2 = b2Name
        
        alert_type = "two_buttons"
    }
    
    //Initialize alert message with single button
    init(title: String, msg: String, vc: UIViewController, bName: String, style: UIAlertController.Style){
        self.title = title
        self.msg = msg
        self.vc = vc
        self.b1 = bName
        self.style = style
        
        alert_type = "single_button_style"
    }
    
    //Initialize alert message with two buttons
    init(title: String, msg: String, vc: UIViewController, b1Name: String, b2Name:String, style: UIAlertController.Style){
        self.title = title
        self.msg = msg
        self.vc = vc
        self.b1 = b1Name
        self.b2 = b2Name
        self.style = style
        
        alert_type = "two_buttons_style"
    }
    
    //show relevent alert
    func show(completion: @escaping (_ clicked_on: Int) -> Void){
        switch alert_type {
            
        case "no_button":
            showAlert()
            break
            
        case "single_button":
            showAlertWithOneButton(completion: {(clicked_on) in
                completion(clicked_on)
            })
            
            break
            
        case "two_buttons":
            showAlertWithTwoButton(completion: {(clicked_on) in
                completion(clicked_on)
            })
            break
            
        case "single_button_style":
            showAlertWithOneButton(completion: {(clicked_on) in
                completion(clicked_on)
            })
            break
            
        case "two_buttons_style":
            showAlertWithTwoButton(completion: {(clicked_on) in
                completion(clicked_on)
            })
            break
            
        default:
            completion(0)
        }
    }
    
    //Show alert message
    private func showAlert(){
        
        let alertController = UIAlertController(title: title, message:
            msg, preferredStyle: style)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default,handler: {(action:UIAlertAction) in
            
        }))
        
        vc.present(alertController, animated: true, completion: nil)
    }
    
    //Show alert message with single button
    private func showAlertWithOneButton(completion: @escaping (_ clicked_on: Int) -> Void){
        
        let alertController = UIAlertController(title: title, message:
            msg, preferredStyle: style)
        alertController.addAction(UIAlertAction(title: b1, style: UIAlertAction.Style.default,handler: {(action:UIAlertAction) in
            completion(1)
        }))
        
        vc.present(alertController, animated: true, completion: nil)
    }
    
    //Show alert message with two buttons
    private func showAlertWithTwoButton(completion: @escaping (_ clicked_on: Int) -> Void) {
        
        let alertController = UIAlertController(title: title, message:
            msg, preferredStyle: style)
        
        alertController.addAction(UIAlertAction(title: b1, style: UIAlertAction.Style.default,handler: {(action:UIAlertAction) in
            
            completion(1)
            
        }))
        
        alertController.addAction(UIAlertAction(title: b2, style: UIAlertAction.Style.default,handler: {(action:UIAlertAction) in
            
            completion(2)
            
        }))
        
        vc.present(alertController, animated: true, completion: nil)
        
    }
    
}
