//
//  PatientForm.swift
//  ToddsSyndrome
//
//  Created by Javier Roberto Manzo on 6/1/16.
//  Copyright © 2016 Javier Roberto Manzo. All rights reserved.
//

import UIKit
import Eureka
import Whisper

protocol TSPatientFormDelegate{
    func addPatient(patient:TSPatient)
    func editPatient(patient:TSPatient)
}

class TSPatientForm: FormViewController {
    
    var patient: TSPatient?
    
    @IBOutlet weak var addButton: UIButton!
    
    var delegate:TSPatientFormDelegate! = nil
    
    var editingPatient = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "New Patient"
        
        DateRow.defaultRowInitializer = { row in row.maximumDate = NSDate() }
        
        self.form =
            
            Section()
            
            <<< IntRow() {
                $0.title = "Document Number"
                $0.placeholder = "Ingress DN"
                $0.tag = "DocumentNumber"
                if (patient != nil){
                    $0.disabled = true
                }
                }.cellSetup { cell, _  in
                    cell.textField.keyboardType = .NumberPad
            }
            
            <<< TextRow() {
                $0.title = "Name"
                $0.placeholder = "Ingress name"
                $0.tag = "Name"
            }
            
            <<< SegmentedRow<String>(){
                $0.title = "Gender"
                $0.options = ["Male", "Female", "Other"]
                $0.tag = "Gender"
            }
            
            <<< DateRow() {
                $0.value = NSDate();
                $0.title = "Birth Date"
                $0.tag = "BirthDate"
            }
            
            <<< SwitchRow() {
                $0.title = "Has Mirgranes"
                $0.value = false
                $0.tag = "Mirgranes"
            }
            <<< SwitchRow() {
                $0.title = "Consume Drugs"
                $0.value = false
                $0.tag = "ConsumeDrugs"
            }
            
            +++ Section("")
        
        if (patient != nil){
            editingPatient = true
            self.fillPatientData(patient!)
            self.addButton.titleLabel?.text = "Edit Patient"
        }
        
        self.view .bringSubviewToFront(self.addButton)
    }
    
    
    
    func fillPatientData(patient: TSPatient) {
        self.form.rowByTag("Name")?.baseValue = patient.name
        self.form.rowByTag("DocumentNumber")?.baseValue = patient.documentNumber
        
        self.form.rowByTag("Gender")?.baseValue = patient.gender
        self.form.rowByTag("BirthDate")?.baseValue = patient.birthDate
        self.form.rowByTag("Mirgranes")?.baseValue = patient.migraines
        self.form.rowByTag("ConsumeDrugs")?.baseValue = patient.consumeDrugs
    }
    
    @IBAction func addPatient(sender: AnyObject) {
        
        //check if the form is completed
        if (((self.form.rowByTag("Name")!.baseValue) != nil)
            && ((self.form.rowByTag("DocumentNumber")!.baseValue) != nil)
            && ((self.form.rowByTag("Gender")!.baseValue) != nil)
            && ((self.form.rowByTag("BirthDate")!.baseValue) != nil) ) {
            
            //check if document number already added
            if TSUserDefaultsHelper.getIndexPatientInListWithDocumentNumber(self.form.rowByTag("DocumentNumber")!.baseValue as! Int) != nil {
                let message = Message(title: "Document Number already added", backgroundColor: UIColor.redColor())
                
                Whisper(message, to: navigationController!, action: .Show)
            } else{
                patient = TSPatient(name: self.form.rowByTag("Name")!.baseValue as! String,
                                    documentNumber: self.form.rowByTag("DocumentNumber")!.baseValue as! Int,
                                    gender: self.form.rowByTag("Gender")!.baseValue as! String,
                                    birthDate: self.form.rowByTag("BirthDate")!.baseValue as! NSDate,
                                    migraines: self.form.rowByTag("Mirgranes")!.baseValue! as! Bool,
                                    consumeDrugs: self.form.rowByTag("ConsumeDrugs")!.baseValue! as! Bool)
                
                
                if editingPatient == true {
                    self.delegate.editPatient(patient!)
                    
                } else{
                    self.delegate.addPatient(patient!)
                }
                
                self.navigationController?.popViewControllerAnimated(true)
                
            }
            
        } else {
            let message = Message(title: "Complete all the form", backgroundColor: UIColor.redColor())
            
            Whisper(message, to: navigationController!, action: .Show)
            
        }
    }
    
    
}
