//
//  File.swift


import Foundation

let personVIPGuest = PersonType.init(firstName: "Girl1", lastName: "", company: "", streetAddress: "", city: "", state: "", zipCode: "11000", dOB: "", dateOfVisit: "")

let personHourly = PersonType.init(firstName: "Neil", lastName: "Strong", company: "", streetAddress: "1550 NoWhere", city: "Cairo", state: "New York", zipCode: "11234", dOB: "", dateOfVisit: "")

let personSeniorGuest = PersonType.init(firstName: "Susie", lastName: "Strong", company: "", streetAddress: "", city: "", state: "", zipCode: "", dOB: newDate?.description, dateOfVisit: nil)

let date = DateFormatter()
let newDate = date.date(from: "09081989")
let personVendor = PersonType.init(firstName: "Mat", lastName: "Clevelander", company: "Acme", streetAddress: "", city: "", state: "", zipCode: "", dOB: newDate?.description, dateOfVisit: String(describing: NSDate.init()))


let vip = NameTag.init(person: personVIPGuest, personType: GuestTypes.vip)
let hourly = NameTag(person: personHourly, personType: OutSource.contract(1001) )
let seniorguest = NameTag(person: personSeniorGuest, personType: GuestTypes.season)
let vendor = NameTag(person: personVendor, personType: OutSource.vendor(personVendor.company))

let finalOptionsArray = [vip, hourly, seniorguest, vendor]
