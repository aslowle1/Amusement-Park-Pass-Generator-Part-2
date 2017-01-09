//
//  GrantAccessModel.swift
//  AmusementPark
//
//  Created by Andros Slowley on 1/4/17.
//  Copyright © 2017 Andros Slowley. All rights reserved.
//

import Foundation
import UIKit

typealias PercentageDiscount = Double
typealias ProjectNumber = Int
typealias CompanyName = String


enum AccessTypes {
    case amusement(RideAccess)
    case kitchen
    case rideControl
    case maintenance
    case office
}

enum RideAccess {
    case all
    case skipAll
    case none
    
}

let vendorlist: [CompanyName: [AccessTypes]] = ["Acme":[.kitchen],
                                                "Orkin":[.amusement(.none),.rideControl, .kitchen],
                                                "Fedex": [.maintenance, .office],
                                                "NW Electrical": [.amusement(.none),.rideControl,.kitchen,.maintenance,.office]]
let projectList: [ProjectNumber: [AccessTypes]] = [1001: [.amusement(.none),.rideControl],
                                                   1002: [.amusement(.none), .rideControl, .maintenance],
                                                   1003:[.amusement(.none), .rideControl, .kitchen,.maintenance, .office],
                                                   2001: [.office],
                                                   2002: [.kitchen, .maintenance] ]


enum DiscountAccess {
    case Food(PercentageDiscount)
    case Merchandise(PercentageDiscount)
}


protocol Entranees {
}

enum EmployeeTypes: Entranees {
    case foodServices
    case rideServices
    case maintenace
    case manager
    
    /*func access() -> [AccessTypes]? {
        let temp: [AccessTypes]?
        switch self {
        case .foodServices: temp = [.amusement(.none), .kitchen]
        case .maintenace: temp = [.amusement(.none),.rideControl, .kitchen, .maintenance]
        case .manager: temp = [.amusement(.none),.rideControl, .kitchen, .maintenance, .office]
        case .rideServices: temp = [.amusement(.all), .rideControl]
        }
        return temp
    }
    
    func availableDiscounts() -> [DiscountAccess]? {
        var answer: [DiscountAccess]? = []
        switch self {
        case .rideServices, .maintenace,.foodServices: answer = [.Food(0.10), .Merchandise(0.20)]
        case .manager: answer = [.Food(0.25), .Merchandise(0.25)]
        }
        return answer}*/

}

enum OutSource: Entranees {
    case vendor(CompanyName)
    case contract(ProjectNumber)

   /* func access() {
        switch self -> [AccessTypes] {
            case .vendor(let name) =
        }
    }*/
}

enum GuestTypes: Entranees {
    case classic
    case vip
    case freechild
    case season
    case senior
    }

class PersonType {
    var firstName: String?
    var lastName: String?
    var streetAddress: String?
    var city: String?
    var state: String?
    var zipCode: Int?
    var dOB: NSDate?
    var photo: UIImage?
    var dateOfVisit: NSDate?
    
}

class BusinessProfile: PersonType {
    required init(firstName: String,lastName: String, streetAddress: String, city: String, state: String, zipCode: Int, dOB: NSDate) {
        super.init()
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.dOB = dOB
    }
}

class Guest: PersonType {
}

class FreeChildGuest: Guest {
    required init(photo: UIImage, dOB: NSDate) {
        super.init()
        super.photo = photo
        super.dOB = dOB
    }
}

class SeniorGuest: Guest {
    required init(firstName: String,lastName: String,dOB: NSDate) {
        super.init()
        super.firstName = firstName
        super.lastName = lastName
        super.dOB = dOB
    }
}

class SeasonPassGuest: Guest {
    required init(firstName: String,lastName: String, streetAddress: String, city: String, state: String, zipCode: Int, dOB: NSDate) {
        super.init()
        self.firstName = super.firstName
        self.lastName = super.lastName
        self.streetAddress = super.streetAddress
        self.city = super.city
        self.state = super.state
        self.zipCode = super.zipCode
        self.dOB = super.dOB
    }
}

class Vendor: PersonType {
    required init(firstName: String,lastName: String,dOB: NSDate, dateOfVisit: NSDate) {
       super.init()
        super.firstName = firstName
        super.lastName = lastName
        super.dOB = dOB
        super.dateOfVisit = dateOfVisit
}

    class Contractor: PersonType {
        required init(firstName: String,lastName: String, streetAddress: String, city: String, state: String, zipCode: Int, dOB: NSDate) {
            super.init()
            self.firstName = firstName
            self.lastName = lastName
            self.streetAddress = streetAddress
            self.city = city
            self.state = state
            self.zipCode = zipCode
            self.dOB = dOB
        }
    }

    


class Access {
    
    var type: Entranees
    let personalInformation: PersonType
    
    init(type: Entranees, personalInformation: PersonType) throws {
        
        if (personalInformation is BusinessProfile && type is EmployeeTypes) ||
            (personalInformation is Guest && type is GuestTypes ) ||
            (personalInformation is Vendor && type is OutSource) ||
            (personalInformation is Contractor && type is OutSource)
            {
            self.personalInformation = personalInformation
            self.type = type
        }
    throw Errors.wrongAccessProvided
    }
    
    func accessible() throws -> [AccessTypes] {
        var answer: [AccessTypes] = []
        switch type {
        case is GuestTypes: let temp = type as! GuestTypes;
        switch temp {
        case .classic, .freechild: answer = [.amusement(.all)]
        case .vip, .senior, .season: answer = [.amusement(.all), .amusement(.skipAll)]}
        case is EmployeeTypes: let temp = type as! EmployeeTypes; switch temp {
        case .foodServices: answer = [.amusement(.all), .kitchen]
        case .maintenace: answer = [.amusement(.all), .kitchen, .rideControl, .maintenance]
        case .manager: answer = [.amusement(.all), .kitchen, .rideControl, .maintenance, .office]
        case .rideServices: answer = [.amusement(.all), .rideControl]}
        case is OutSource: let temp = type as! OutSource; switch temp {
        case .vendor(let name): answer = vendorlist[name]!
        case .contract(let project): answer = projectList[project]!
            }
        default: break}
return answer}
    

    
    
    func availableDiscounts() -> [DiscountAccess]? {
        var answer: [DiscountAccess]? = []
        switch type {
        case is GuestTypes: let temp = type as! GuestTypes;
        switch temp {
        case .classic, .freechild: answer = nil
        case .vip, .season: answer = [.Food(0.10), .Merchandise(0.20)]
        case .senior: answer = [.Food(0.10),.Merchandise(0.10)]}
        case is EmployeeTypes: let temp = type as! EmployeeTypes; switch temp {
        case .rideServices, .maintenace,.foodServices: answer = [.Food(0.10), .Merchandise(0.20)]
        case .manager: answer = [.Food(0.25), .Merchandise(0.25)]
            }
        case is OutSource: let temp = type as! OutSource; switch temp {
        case .contract, .vendor: answer = nil}
        default: break}
    return answer}
}

enum Errors: Error {
    case wrongAccessProvided
    case checkEntrantRules([AccessTypes])
}
    }

