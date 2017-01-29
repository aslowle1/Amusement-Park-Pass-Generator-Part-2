//
//  ViewController.swift
//  AmusementPark
//
//  Created by Andros Slowley on 1/4/17.
//  Copyright © 2017 Andros Slowley. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        for index in buttons {
            index?.setTitle("", for: .normal)
        }
        for index in textFields {
            index?.delegate = self
        }
        generatePassButton.isEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.incoming(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.incoming(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        datePicker.isHidden = true
        
        var date =  String(describing: NSDate.init())
        ssn.text = date.remove()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        _ = textFields.map() { $0?.text = ""}
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if ((touches.first?.location(in: self.view)) != nil) {
            populateData.isHidden = false
            generatePassButton.isHidden = false
            datePicker.isHidden = true
            self.view.endEditing(true)
        }
    }
    
    @IBOutlet weak var lengthFromBottom: NSLayoutConstraint!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var dOB: UITextField!
    @IBOutlet weak var ssn: UITextField!
    @IBOutlet weak var pjNumber: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var company: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var firstNme: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var generatePassButton: UIButton!
    @IBOutlet weak var populateData: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var buttons: [UIButton?] { get { return [button1, button2, button3, button4, button5] } }
    var textFields: [UITextField?] { get { return [ firstNme, lastName, pjNumber, dOB, ssn, company, address, city, state, zipCode] } }
    var parameterRelationship: [String: UITextField] = [:]
    var notificationCount = 0
    var populatePerson: PersonType?
    var selectedButton: UIButton?
    var person: Entranees?
   
    func allPossibleEmployees(personellType: [String]) {
        
        let person = personellType
        for index in buttons {
            index?.isHidden = false
        }
        let difference = buttons.count - person.count
        for index1 in 0...person.count - 1 {
            buttons[index1]?.setTitle(person[index1], for: .normal)
            
            if difference != 0 {
                for index in 1...(difference) {
                    buttons[buttons.count - index]?.isHidden = true
                }
                
            }
        }
        _ = buttons.map() {$0?.isEnabled = true}
        
    }
    
    @IBAction func mainGuestButton() {
        
    allPossibleEmployees(personellType: GuestTypes.guestArray)
    }
    
    @IBAction func mainEmployeeButton() {
       
        allPossibleEmployees(personellType: EmployeeTypes.employeeArray)    }
    
    @IBAction func outSourceButton() {
        
        allPossibleEmployees(personellType: OutSource.outSourceArray)
    }
   
    func createPerson() -> PersonType{
        return  PersonType.init(firstName: firstNme.text, lastName: lastName.text, company: company.text, streetAddress:address.text, city: city.text, state: state.text, zipCode: zipCode.text, dOB: dOB.text, dateOfVisit: ssn.text)
    }
    
    
    func resetPlaceHolders() {
        for index in textFields {
            index?.placeholder = ""
        }
        
    }
    
    @IBAction func selectButton(_ sender: UIButton) {
        resetPlaceHolders()
        requiredFields = []
        switch sender.currentTitle! {
        case GuestTypes.guestArray[0], GuestTypes.guestArray[1]: break
        case GuestTypes.guestArray[2]: dOB.placeholder = "Required"; requiredFields = [dOB]
        case GuestTypes.guestArray[3]:for index in [firstNme, lastName, dOB] {
            index?.placeholder = "Required"
            requiredFields.append(index!)
            }
        case "Food Services", "Ride Services", "Maintenace", "Manager", "Season", "Contract": for index in [firstNme, lastName,address,city,state,zipCode] {
            index?.placeholder = "Required"
            if sender.currentTitle! == "Contract" {
                pjNumber.placeholder = "Required"
            }
            requiredFields.append(index!)
            }
        case "Vendor": for index in [firstNme, lastName,company,dOB,ssn] {
            index?.placeholder = "Required"
            requiredFields.append(index!)
            }
            
        default: break
        }
selectedButton = sender
        if let currentType = EmployeeTypes.init(rawValue: (selectedButton?.currentTitle)!) {
            person = currentType
        } else if let currentType = GuestTypes.init(rawValue: (selectedButton?.currentTitle)!) {
            person = currentType
        } else {
            person = OutSource.init(rawValue: (selectedButton?.currentTitle)!)
        }
        generatePassButton.isEnabled = true
         _ = textFields.map( { $0?.isEnabled = true})
    }

    
    @IBAction func generatePass() {
      
        for (index) in requiredFields {

            
            if let index = index as? UITextField {
            
                if index.text?.isEmpty == false {
                    if selectedButton?.currentTitle == "Vendor" {
                        
                        switch  company.text! {
                           case "Acme", "Orkin", "Fedex", "NW Electrical": continue
                        default: present(alert(), animated: true, completion: nil)
                        }
                    }
                    
                    if selectedButton?.currentTitle == "Contract" {
                        
                        switch  Int(pjNumber.text!)! {
                        case 1001, 1002, 1003, 2001, 2002: continue
                        default: present(alert(), animated: true, completion: nil)
                        }
                    }
                    continue
            
                } else { present(alert(), animated: true, completion: nil)}
            
            }
        }
        
        
    }
    
    @IBAction func populateData(_ sender: UIButton) {
    
        
    }
    
    func alert() -> UIAlertController {
        let alert = UIAlertController.init(title: MissingInfoError.domainLocal, message: MissingInfoError.userInfo[NSLocalizedDescriptionKey], preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Okay", style: .default, handler: nil))
        return alert
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        return false
    }
    
    func incoming(notification: NSNotification) {

        if notification.name == NSNotification.Name.UIKeyboardWillShow && (dOB.isFirstResponder == false){
            
        if let notifcationInfo = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] {
            if notificationCount == 0 {
                notificationCount += 1
            if let size = notifcationInfo as? CGRect {
                lengthFromBottom.constant += (size.height)/1.5
                
            }
            }
            }
        } else if notificationCount == 1 {
            
            if let notifcationInfo = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] {
                if let size = notifcationInfo as? CGRect {
                    lengthFromBottom.constant -= (size.height)/1.5
                    notificationCount -= 1
                }
            }
        }
        
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   
        if segue.identifier == "CreatePass" {
            if let secondPage = segue.destination as? PassViewController {
                secondPage.pageInfo = NameTag.init(person: createPerson(), personType: person!)
            }
        } else if segue.identifier == "populate" {
            if let secondPage = segue.destination as? PassViewController {
                secondPage.pageInfo = finalOptionsArray[Int(arc4random_uniform(UInt32(finalOptionsArray.count)))]
            }
        }
    }

    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    
        if textField == pjNumber || textField == zipCode {
            textField.keyboardType = .numberPad
        }
        
        if textField == dOB || textField == ssn{
            populateData.isHidden = true
            generatePassButton.isHidden = true
            datePicker.isHidden = false
self.view.endEditing(true)
            
            switch textField {
            case dOB:
                dOB.isHighlighted = true
                ssn.isHighlighted = false
            case ssn:
                dOB.isHighlighted = false
                ssn.isHighlighted = true
            default:
                break
            }
            return false
        }
        populateData.isHidden = false
        generatePassButton.isHidden = false
        datePicker.isHidden = true
        return true
    }


    @IBAction func dateChanger(_ sender: UIDatePicker) {
        var dateString = String(describing: sender.date)
        if dOB.state == .highlighted {
        dOB.text = dateString.remove()
        } else if ssn.state == .highlighted {
            ssn.text = dateString.remove()}
        
    
    }

}

extension String {
    mutating func remove() -> String {
        let arrayString = self as NSString
        let range = NSRange.init(location: 10, length: 15)
        self = arrayString.replacingCharacters(in: range, with: "")
return self
        }
    }

