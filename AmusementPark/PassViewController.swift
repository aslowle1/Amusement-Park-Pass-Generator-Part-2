//
//  PassViewController.swift
//  AmusementPark
//
//  Created by Andros Slowley on 1/18/17.
//  Copyright © 2017 Andros Slowley. All rights reserved.
//

import UIKit

class PassViewController: UIViewController {

    var pageInfo: NameTag?
    var nameTagView = Tag()

    var nameTageStack = UIStackView.init()
    var namesStackView = UIStackView.init()
    var accessDiscounts = UIStackView.init()
    var allLabels = UIStackView.init()
    var areaAccessStackView = UIStackView.init()
    
    var access1 = UILabel()
    var access2 = UILabel()
    var access3 = UILabel()
    var access4 = UILabel()
    var access5 = UILabel()
    var personName = UILabel.init()
    var personType = UILabel.init()
    var AccessTestingLabel = UILabel.init()
    var AccessTestingConfirmation = UILabel.init()
    var pagePassHeader = UILabel.init()
    var testResults = UILabel.init()
    var allAccess: [UILabel?]? {get { return [access4,access3,access2,access1]}}
    var discounts: [String: Double]? { return pageInfo?.availableDiscounts()}

    var image = UIImageView.init()
    var areaAccessTestButton = UIButton.init()
    var rideAccessTestButton = UIButton.init()
    var discountAccessTestButton = UIButton.init()
    var createNewPassButton = UIButton.init()
    
    func configureView() {
        
        image.backgroundColor = UIColor.red
        view.backgroundColor = UIColor.init(red: 211/255, green: 205/255, blue: 216/255, alpha: 1.0)
        nameTagView.backgroundColor = UIColor.init(red: 211/255, green: 205/255, blue: 216/255, alpha: 1.0)
        nameTagView.backgroundColor = UIColor.clear

        
        
        
        
        pagePassHeader.backgroundColor = UIColor.init(red: 73.0/255, green: 132/255, blue: 125/255, alpha: 1.0)
        pagePassHeader.text = "Create New Pass"
        pagePassHeader.textAlignment = .center
        pagePassHeader.textColor = UIColor.white
        pagePassHeader.font = UIFont.boldSystemFont(ofSize: 30)
        createNewPassButton.addTarget(self, action: #selector(self.returnAction), for: UIControlEvents.touchUpInside)
    
        personName.text = (pageInfo?.person.firstName)! + (pageInfo?.person.lastName)!
        personName.font = UIFont.boldSystemFont(ofSize: 50)
        personName.numberOfLines = 1
        personName.adjustsFontSizeToFitWidth = true
        personType.font = UIFont.boldSystemFont(ofSize: 29)
        personType.textColor = UIColor.gray
        
        namesStackView.axis = .vertical
        namesStackView.insertArrangedSubview(personName, at: 0)
        namesStackView.addArrangedSubview(personType)
        namesStackView.spacing = 4
        
        
        for index in 0...((pageInfo?.access.count)! - 1) {
            allAccess?[index]?.text = pageInfo?.access[index].getRawValue()
           
        }
        
        
        testResults.numberOfLines = 4
        
        access1.font = UIFont.boldSystemFont(ofSize: 24)
        access1.textColor = UIColor.gray
        access2.font = UIFont.boldSystemFont(ofSize: 24)
        access2.textColor = UIColor.gray
        access3.font = UIFont.boldSystemFont(ofSize: 24)
        access3.textColor = UIColor.gray
        access4.font = UIFont.boldSystemFont(ofSize: 24)
        access4.textColor = UIColor.gray
        
        accessDiscounts.axis = .vertical
        accessDiscounts.addArrangedSubview(access1)
        accessDiscounts.addArrangedSubview(access2)
        accessDiscounts.addArrangedSubview(access3)
        accessDiscounts.addArrangedSubview(access4)
        accessDiscounts.distribution = .equalSpacing
        
        allLabels.axis = .vertical
        allLabels.addArrangedSubview(accessDiscounts)
        allLabels.insertArrangedSubview(namesStackView, at: 0)
        allLabels.contentCompressionResistancePriority(for: .horizontal)
        allLabels.distribution = .equalSpacing
        allLabels.alignment = .top
        

        
        AccessTestingLabel.text = "Access Testing"
        AccessTestingLabel.font = UIFont.boldSystemFont(ofSize: 35)
        AccessTestingConfirmation.text = "Confirm the pass has the expected level of access when swiped at a kiosk"
    AccessTestingConfirmation.font = UIFont.boldSystemFont(ofSize: 24)
        AccessTestingConfirmation.textColor = UIColor.darkGray
        
        
        areaAccessTestButton.backgroundColor = UIColor.init(red: 236/255, green: 232/255, blue: 239/255, alpha: 1.0)
        areaAccessTestButton.setTitle("Area Access", for: .normal)
        areaAccessTestButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        areaAccessTestButton.setTitleColor(UIColor.init(red: 71/255, green: 139/255, blue: 133/255, alpha: 1.0), for: .normal)
        discountAccessTestButton.backgroundColor = UIColor.init(red: 236/255, green: 232/255, blue: 239/255, alpha: 1.0)
        discountAccessTestButton.setTitle("Discount Access", for: .normal)
        discountAccessTestButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        discountAccessTestButton.setTitleColor(UIColor.init(red: 71/255, green: 139/255, blue: 133/255, alpha: 1.0), for: .normal)
        rideAccessTestButton.backgroundColor = UIColor.init(red: 236/255, green: 232/255, blue: 239/255, alpha: 1.0)
        rideAccessTestButton.setTitle("Ride Access", for: .normal)
        rideAccessTestButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        rideAccessTestButton.setTitleColor(UIColor.init(red: 71/255, green: 139/255, blue: 133/255, alpha: 1.0), for: .normal)
        
    areaAccessStackView.axis = .horizontal
        areaAccessStackView.addArrangedSubview(areaAccessTestButton)
        areaAccessStackView.addArrangedSubview(rideAccessTestButton)
        areaAccessStackView.addArrangedSubview(discountAccessTestButton)
    areaAccessStackView.distribution = .equalCentering
    
        testResults.backgroundColor = UIColor.init(red: 192/255, green: 186/255, blue: 196/255, alpha: 1.0)
        testResults.text = "Test Results"
        testResults.textAlignment = .center
        testResults.font = UIFont.boldSystemFont(ofSize: 35)
        testResults.textColor = UIColor.gray
        createNewPassButton.backgroundColor = UIColor.init(red: 192/255, green: 186/255, blue: 196/255, alpha: 1.0)
        createNewPassButton.setTitle("Create New Pass", for: .normal)
        createNewPassButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 27)
        
    }
    
    func returnAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        view.addSubview(pagePassHeader)
        view.addSubview(nameTagView)
        view.addSubview(AccessTestingLabel)
        view.addSubview(AccessTestingConfirmation)
        view.addSubview(areaAccessStackView)
        view.addSubview(testResults)
        view.addSubview(createNewPassButton)
        nameTagView.addSubview(image)
        nameTagView.addSubview(allLabels)
        
        self.configureView()
        image.image = #imageLiteral(resourceName: "FaceImageAsset")
   
        areaAccessTestButton.addTarget(self, action: #selector(self.accessTest(press:)), for: .touchUpInside)
        rideAccessTestButton.addTarget(self, action: #selector(self.accessTest(press:)), for: .touchUpInside)
        discountAccessTestButton.addTarget(self, action: #selector(self.accessTest(press:)), for: .touchUpInside)
    
        
           }

    
    func accessTest(press: UIButton) {
        var temp = [String]()
        testResults.text = ""
        for index in 0...((pageInfo?.access.count)! - 1) {
    
            switch press  {
            case areaAccessTestButton:
            switch pageInfo!.access[index].getRawValue() {
            case "Amusement - Ride Access", "Amusement - No Ride Access", "Amusement - Skip All Rides" : temp.insert(pageInfo!.access[index].getRawValue(), at: 0);
            testResults.backgroundColor = UIColor.green
            default: continue}
            case rideAccessTestButton:
                switch pageInfo!.access[index].getRawValue() {
                case "Kitchen Access", "Ride Control Access","Maintenance Access","Office Access": temp.insert(pageInfo!.access[index].getRawValue(), at: 0);
                testResults.backgroundColor = UIColor.green
                default: continue}
            case discountAccessTestButton:
                temp = ["empty"]
                if index < 1 {
                            if pageInfo?.availableDiscounts()?["Food"] != nil || pageInfo?.availableDiscounts()?["Merchandise"] != nil {
                    print(pageInfo?.availableDiscounts()?["Food"] as Any)
                                testResults.text?.append(" Food Discount: \(pageInfo!.availableDiscounts()!["Food"]!)")
                                testResults.text?.append("\n Merchandise Discount: \(pageInfo!.availableDiscounts()!["Merchandise"]!)")
                                testResults.backgroundColor = UIColor.green
                } else  {
                    testResults.text? = "No Discounts"
                                testResults.backgroundColor = UIColor.red
                }
                }

            default: continue}
    
        }
    
        if temp != ["empty"] && temp.isEmpty == false {
        for index in 0...temp.count - 1 {
            if index < 1 {
                testResults.text?.append(temp[index])
            } else {
                testResults.text?.append("\n \(temp[index])")
            }
            
        }
        } else if temp.isEmpty {testResults.backgroundColor = UIColor.red; testResults.text? = "No Access" }
temp = [String]()
}

    override func viewWillLayoutSubviews() {

        pagePassHeader.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [(pagePassHeader.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 50)),
            (pagePassHeader.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0)),
            (pagePassHeader.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)),
            (pagePassHeader.heightAnchor.constraint(equalToConstant: 100.0))])
    
        
    nameTagView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [nameTagView.topAnchor.constraint(equalTo: pagePassHeader.bottomAnchor, constant: 50),
        nameTagView.leftAnchor.constraint(equalTo: pagePassHeader.leftAnchor, constant: 60),
        nameTagView.rightAnchor.constraint(equalTo: pagePassHeader.rightAnchor, constant: -60),
        nameTagView.heightAnchor.constraint(equalToConstant: 400)])
    
    
        allLabels.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [allLabels.topAnchor.constraint(equalTo: nameTagView.topAnchor, constant: 90),
        allLabels.bottomAnchor.constraint(equalTo: nameTagView.bottomAnchor, constant: -60),
        allLabels.centerXAnchor.constraint(equalTo: nameTagView.centerXAnchor, constant: 100),
        ])
    
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [image.topAnchor.constraint(equalTo: allLabels.topAnchor),
             image.bottomAnchor.constraint(equalTo: allLabels.bottomAnchor),
             image.widthAnchor.constraint(equalToConstant: 260),
             image.rightAnchor.constraint(equalTo: allLabels.leftAnchor, constant: -40)
            ])
 
        
        AccessTestingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [AccessTestingLabel.topAnchor.constraint(equalTo: nameTagView.bottomAnchor, constant: 70),
             AccessTestingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
            ])
   
        AccessTestingConfirmation.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [AccessTestingConfirmation.topAnchor.constraint(equalTo: AccessTestingLabel.bottomAnchor, constant: 5),
             AccessTestingConfirmation.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
            ])

    areaAccessTestButton.translatesAutoresizingMaskIntoConstraints = false
        discountAccessTestButton.translatesAutoresizingMaskIntoConstraints = false
        rideAccessTestButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [areaAccessTestButton.widthAnchor.constraint(equalToConstant: 250),
             areaAccessTestButton.heightAnchor.constraint(equalToConstant: 70),
             discountAccessTestButton.widthAnchor.constraint(equalToConstant: 250),
             discountAccessTestButton.heightAnchor.constraint(equalToConstant: 70),
             rideAccessTestButton.widthAnchor.constraint(equalToConstant: 250),
             rideAccessTestButton.heightAnchor.constraint(equalToConstant: 70),
            ])

        areaAccessStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [areaAccessStackView.topAnchor.constraint(equalTo: AccessTestingConfirmation.topAnchor, constant: 90),
             areaAccessStackView.leftAnchor.constraint(equalTo: nameTagView.leftAnchor, constant: 25),
             areaAccessStackView.rightAnchor.constraint(equalTo: nameTagView.rightAnchor, constant: -25)
            ])
        
        testResults.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [testResults.topAnchor.constraint(equalTo: areaAccessStackView.bottomAnchor, constant: 70),
             testResults.leftAnchor.constraint(equalTo: nameTagView.leftAnchor, constant: 25),
             testResults.rightAnchor.constraint(equalTo: nameTagView.rightAnchor, constant: -25),
             testResults.heightAnchor.constraint(equalToConstant: 250)
            ])
        
    
        createNewPassButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [createNewPassButton.topAnchor.constraint(equalTo: testResults.bottomAnchor, constant: 45),
             createNewPassButton.widthAnchor.constraint(equalToConstant: 300),
             createNewPassButton.heightAnchor.constraint(equalToConstant: 90),
             createNewPassButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])

    }
    
}
