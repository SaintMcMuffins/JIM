//
//  register.swift
//  J.I.M
//
//  Created by Julian Manaois on 10/18/22.
//

import UIKit

class ViewController: UIViewController {

@IBOutlet weak var txtFName: UITextField!
@IBOutlet weak var txtLName: UITextField!
@IBOutlet weak var txtEmailID: UITextField!
@IBOutlet weak var txtPassword: UITextField!
@IBOutlet weak var txtConfirmPassword: UITextField!

override func viewDidLoad() {
super.viewDidLoad()
// Do any additional setup after loading the view, typically from a nib.
}

override func didReceiveMemoryWarning() {
super.didReceiveMemoryWarning()
// Dispose of any resources that can be recreated.
}

@IBAction func btnRegistration(sender: AnyObject)
{
if(countElements(txtFName.text) == 0){
var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your first name.",
delegate: nil, cancelButtonTitle: "OK")
alert.show()

}else if (countElements(txtLName.text) == 0){
var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your last name.",
delegate: nil, cancelButtonTitle: "OK")
alert.show()

}else if (countElements(txtEmailID.text) == 0){
var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your email id.",
delegate: nil, cancelButtonTitle: "OK")
alert.show()

}else if !isValidEmail(txtEmailID.text){
var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your correct email id.",
delegate: nil, cancelButtonTitle: "OK")
alert.show()

}else if (countElements(txtPassword.text) == 0){
var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Please enter your password.",
delegate: nil, cancelButtonTitle: "OK")
alert.show()

}else if (countElements(txtConfirmPassword.text) != countElements(txtPassword.text)){
var alert : UIAlertView = UIAlertView(title: "Oops!", message: "Confirmed password not matched please try again.",
delegate: nil, cancelButtonTitle: "OK")
alert.show()

}else{
var alert : UIAlertView = UIAlertView(title: "User Registration!", message: "Your Registration is successfully.",
delegate: nil, cancelButtonTitle: "OK")
alert.show()

}

}



func textFieldShouldReturn(textField: UITextField) -> Bool
{
if(textField.returnKeyType == UIReturnKeyType.Done)
{
textField .resignFirstResponder()
}
else
{
var txtFld : UITextField? = self.view.viewWithTag(textField.tag + 1) as? UITextField;
txtFld?.becomeFirstResponder()
}
return true
}

func isValidEmail(testStr:String) -> Bool {
let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"

var emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
let result = emailTest.evaluateWithObject(testStr)
return result
}

}