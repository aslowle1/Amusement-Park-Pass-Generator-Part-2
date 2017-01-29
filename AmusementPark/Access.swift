//
//  Access.swift
//  AmusementPark
//
//  Created by Andros Slowley on 1/15/17.
//  Copyright © 2017 Andros Slowley. All rights reserved.
//

import UIKit

typealias PercentageDiscount = Double
typealias ProjectNumber = Int
typealias CompanyName = String
var requiredFields: [AnyObject] = []


protocol Entranees {
    func getRawValue() -> String
}

enum EmployeeTypes: Entranees  {
    case foodServices
    case rideServices
    case maintenace
    case manager
   
    static let employeeArray = ["Food Services", "Ride Services", "Maintenance", "Manager"]
    
    init?(rawValue: String) {
        switch rawValue {
        case EmployeeTypes.employeeArray[0]: self = .foodServices
        case EmployeeTypes.employeeArray[1]: self = .rideServices
        case EmployeeTypes.employeeArray[2]: self = .maintenace
        case EmployeeTypes.employeeArray[3]: self = .manager
        default: return nil
        }
    }
    
    
    func getRawValue() -> String {
        let value: String
        switch self {
        case .foodServices: value = EmployeeTypes.employeeArray[0]
        case .rideServices: value = EmployeeTypes.employeeArray[1]
        case .maintenace: value = EmployeeTypes.employeeArray[2]
        case .manager: value = EmployeeTypes.employeeArray[3]
        }
    return value }

}

enum OutSource: Entranees {
    case vendor(CompanyName?)
    case contract(ProjectNumber?)
    
    enum vendorNames: String {
        case Acme
        case Orkin
        case Fedex
        case NWElectric = "NW Electric"
        func rawValue1() -> String {
            var temp: String
            switch self {
            case .Acme: temp = "Acme"
            case .Orkin: temp = "Orkin"
            case .Fedex: temp = "Fedex"
            case .NWElectric: temp = "NW Electrical"
            }
        return temp}

    }
    static let outSourceArray = ["Vendor", "Contract"]
    
    static let vendorlist: [CompanyName: [NameTag.AccessTypes]] = ["Acme":[.kitchen],
                                                    "Orkin":[.amusement(.none),.rideControl, .kitchen],
                                                    "Fedex": [.maintenance, .office],
                                                    "NW Electrical": [.amusement(.none),.rideControl,.kitchen,.maintenance,.office]]
    static let projectList: [ProjectNumber: [NameTag.AccessTypes]] = [1001: [.amusement(.none),.rideControl],
                                                       1002: [.amusement(.none), .rideControl, .maintenance],
                                                       1003:[.amusement(.none), .rideControl, .kitchen,.maintenance, .office],
                                                       2001: [.office],
                                                       2002: [.kitchen, .maintenance] ]

    init?(rawValue: String) {
        switch rawValue {
        case OutSource.outSourceArray[0]: self = .contract(nil)
        case OutSource.outSourceArray[1]: self = .vendor(nil)
        default: return nil
        }
    }
    
    
    func getRawValue() -> String {
        var value: String = ""
        switch self {
        case .contract( _): value = OutSource.outSourceArray[1]
        case .vendor( _): value = OutSource.outSourceArray[0]
    }
        return value }
}


enum GuestTypes:  Entranees {
    case classic
    case vip
    case freechild
    case season
    case senior
    
    static let guestArray = ["VIP", "Classic", "Free Child", "Senior", "Season"]
    
    
    init?(rawValue: String) {
        switch rawValue {
        case GuestTypes.guestArray[0]: self = .vip
        case GuestTypes.guestArray[1]: self = .classic
        case GuestTypes.guestArray[2]: self = .freechild
        case GuestTypes.guestArray[3]: self = .senior
        case GuestTypes.guestArray[4]: self = .season
    default: return nil
        }
    }
  
    
    func getRawValue() -> String {
        let value: String
        switch self {
        case .vip: value = GuestTypes.guestArray[0]
        case .classic: value = GuestTypes.guestArray[1]
        case .freechild: value = GuestTypes.guestArray[2]
        case .senior: value = GuestTypes.guestArray[3]
        case .season: value = GuestTypes.guestArray[4]
        }
        return value }
    
}


class PersonType {
    var firstName: String?
    var lastName: String?
    var company: String?
    var streetAddress: String?
    var city: String?
    var state: String?
    var zipCode: String?
    var dOB: String?
    var dateOfVisit: String?
    
    init(firstName: String?, lastName: String?, company: String?, streetAddress: String?, city: String?, state: String?, zipCode: String?, dOB: String?, dateOfVisit: String?) {
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.company = company
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.dOB = dOB
        self.dateOfVisit = dateOfVisit
    }
}

class NameTag {
    
    var personType: Entranees?
    var person: PersonType
    enum AccessTypes {
        case amusement(RideAccess)
        case kitchen
        case rideControl
        case maintenance
        case office
        
        enum RideAccess {
            case all
            case skipAll
            case none
        }
        
        
        
        func getRawValue() -> String {
            let value: String
            switch self {
            case .amusement(.all): value = "Amusement - Ride Access"
            case .amusement(.skipAll): value = "Amusement - Skip All Rides"
            case .amusement(.none): value = "Amusement - No Ride Access"
            case .kitchen: value = "Kitchen Access"
            case .rideControl: value = "Ride Control Access"
            case .maintenance: value = "Maintenance Access"
            case .office: value = "Office Access"
            }
            return value }
        
    }
    
    enum DiscountAccess {
        case Food(PercentageDiscount)
        case Merchandise(PercentageDiscount)
        
        func rawValue() ->[String:Double] {
            let value: [String:Double]
            switch self {
            case .Food(let discount): value = ["Food": discount]
            case .Merchandise(let discount): value = ["Merchandise": discount]
            }
        return value}
        
    }
    
    var access: [AccessTypes] {
        var answer: [AccessTypes] = []
        switch personType {
        case is GuestTypes: let temp = personType as! GuestTypes;
        switch temp {
        case .classic, .freechild: answer = [.amusement(.all)]
        case .vip, .senior, .season: answer = [.amusement(.all), .amusement(.skipAll)]}
        case is EmployeeTypes: let temp = personType as! EmployeeTypes; switch temp {
        case .foodServices: answer = [.amusement(.all), .kitchen]
        case .maintenace: answer = [.amusement(.all), .kitchen, .rideControl, .maintenance]
        case .manager: answer = [.amusement(.all), .kitchen, .rideControl, .maintenance, .office]
        case .rideServices: answer = [.amusement(.all), .rideControl]}
        case is OutSource: let temp = personType as! OutSource; switch temp {
        case .vendor(let name): answer = OutSource.vendorlist[name!]!
        case .contract(let project): answer = OutSource.projectList[project!]!
            }
        default: break}
        return answer}

    func availableDiscounts() -> [String: Double]? {
        var answer: [String: Double]? = [:]
        switch personType {
        case is GuestTypes: let temp = personType as! GuestTypes;
        switch temp {
        case .classic, .freechild: answer = nil
        case .vip, .season: answer = ["Food" : 0.10, "Merchandise" : 0.20]
        case .senior: answer = ["Food" : 0.10, "Merchandise" : 0.10]}
        case is EmployeeTypes: let temp = personType as! EmployeeTypes; switch temp {
        case .rideServices, .maintenace,.foodServices: answer = ["Food" : 0.10, "Merchandise" : 0.20]
        case .manager: answer = nil
            }
        case is OutSource: let temp = personType as! OutSource; switch temp {
        case .contract, .vendor: answer = nil}
        default: break}
        return answer}

    
    init(person: PersonType, personType: Entranees) {
        self.person = person
        self.personType = personType
    }
    
}


enum Errors: Error {
    case wrongAccessProvided
}

struct MissingInfoError{
    static var code = 1
    static var domainLocal = "Misssing Required Info"
    static var userInfo = [NSLocalizedDescriptionKey: "The required information for the indiviual is missing", NSLocalizedRecoverySuggestionErrorKey: "Press OKAY and enter information"]
    
    static let error = NSError.init(domain: domainLocal, code: code, userInfo: userInfo)
}
var errorArray: [String] = []
var MissingKeyError = NSError()
