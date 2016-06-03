//
//  TSUserDefaultsHelper.swift
//  ToddsSyndrome
//
//  Created by Javier Roberto Manzo on 6/2/16.
//  Copyright © 2016 Javier Roberto Manzo. All rights reserved.
//

import Foundation

class TSUserDefaultsHelper {
    
    static func getBundleIndentifier() -> String{
        return NSBundle.mainBundle().bundleIdentifier!
    }
    
    static func saveListPatients(listPatients:NSMutableArray){
        
        let data = NSKeyedArchiver.archivedDataWithRootObject(listPatients)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: getBundleIndentifier() + ".listPatients")
        
    }
    
    static func getListPatients() -> NSMutableArray{
        
        if let data = NSUserDefaults.standardUserDefaults().objectForKey(getBundleIndentifier() + ".listPatients") as? NSData {
            let listPatients = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? NSMutableArray
            return listPatients!
        }
        
        return NSMutableArray()
    }
    
    static func getIndexPatientInListWithDocumentNumber(documentNumber: Int) -> Int?{
        let listPatients = getListPatients()
        for i in 0..<listPatients.count {
            let patient = listPatients[i] as? TSPatient
            if patient?.documentNumber == documentNumber {
                return i
            }
        }
        return nil
    }
}
