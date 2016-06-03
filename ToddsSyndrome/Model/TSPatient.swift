//
//  TSPatient.swift
//  ToddsSyndrome
//
//  Created by Javier Roberto Manzo on 6/1/16.
//  Copyright © 2016 Javier Roberto Manzo. All rights reserved.
//

import UIKit
import SwiftyJSON

class TSPatient: NSObject {
    
    var name: String!
    var documentNumber: Int!
    var gender: String!
    var birthDate: NSDate!
    var migraines: Bool!
    var consumeDrugs: Bool!
    
    init(name: String, documentNumber: Int, gender: String, birthDate: NSDate, migraines: Bool, consumeDrugs: Bool) {
        self.name = name
        self.documentNumber = documentNumber
        self.gender = gender
        self.birthDate = birthDate
        self.migraines = migraines
        self.consumeDrugs = consumeDrugs
    }
    
    //init with JSON data
    init(data: JSON!) {
        
        self.name = data["name"].stringValue
        self.documentNumber = data["documentNumber"].intValue
        self.gender = data["gender"].stringValue
        self.birthDate = data["birthDate"].date
        self.migraines = data["migraines"].bool
        self.consumeDrugs = data["consumeDrugs"].bool
    }
    
    required convenience init?(coder decoder: NSCoder) {
        let name = decoder.decodeObjectForKey("name") as? String
        let documentNumber = decoder.decodeIntForKey("documentNumber")
        let gender = decoder.decodeObjectForKey("gender") as? String
        let birthDate = decoder.decodeObjectForKey("birthDate") as? NSDate
        let migraines = decoder.decodeBoolForKey("migraines")
        let consumeDrugs = decoder.decodeBoolForKey("consumeDrugs")
        
        
        self.init(
            name: name!,
            documentNumber: Int(documentNumber),
            gender: gender!,
            birthDate: birthDate!,
            migraines: migraines,
            consumeDrugs: consumeDrugs
        )
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.name, forKey: "name")
        coder.encodeInt(Int32(self.documentNumber), forKey: "documentNumber")
        coder.encodeObject(self.gender, forKey: "gender")
        coder.encodeObject(self.birthDate, forKey: "birthDate")
        coder.encodeBool(self.migraines, forKey: "migraines")
        coder.encodeBool(self.consumeDrugs, forKey: "consumeDrugs")
    }
    
    func percentageProbability() -> Int {
        var numberFactors = 0
        
        if self.gender == "Male" {
            numberFactors += 1
        }
        
        if self.birthDate.age >= 15 {
            numberFactors += 1
        }
        
        if self.migraines == true {
            numberFactors += 1
        }
        
        if self.consumeDrugs == true {
            numberFactors += 1
        }
        
        let percentage = Int((numberFactors * 100)/4)
        
        return percentage
    }
    
}


