//
//  TSNetworkingHelper.swift
//  ToddsSyndrome
//
//  Created by Javier Roberto Manzo on 6/2/16.
//  Copyright © 2016 Javier Roberto Manzo. All rights reserved.
//

import Foundation
import Alamofire

class TSNetworkingHelper: NSObject {
    
    static let BASE_API_URL = "https://api.com/"
    static let LIST_API_URL = BASE_API_URL + "list"
    static let ADD_API_URL = BASE_API_URL + "add"
    
    static func getPatientsList() {
        
        let parameters = ["userID": "USERID"]
        
        Alamofire.request(.GET, LIST_API_URL, parameters: parameters)
            .responseJSON { response in
                
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                switch response.result {
                case .Success:
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
    
    static func addPatient(patient: TSPatient) {
        let parameters = [
            "name": patient.name,
            "documentNumber": String(patient.documentNumber),
            "birthDate": String(patient.birthDate),
            "gender": patient.gender,
            "migranes": String(patient.migraines),
            "consumeDrugs": String(patient.consumeDrugs)
        ]
        
        Alamofire.request(.POST, ADD_API_URL, parameters: parameters)
            .responseJSON { response in
                
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                switch response.result {
                case .Success:
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
}
