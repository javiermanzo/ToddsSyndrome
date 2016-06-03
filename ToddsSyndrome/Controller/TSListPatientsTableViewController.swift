//
//  TSListPatientsTableViewController.swift
//  ToddsSyndrome
//
//  Created by Javier Roberto Manzo on 6/1/16.
//  Copyright © 2016 Javier Roberto Manzo. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class TSListPatientsTableViewController: UITableViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate,TSPatientFormDelegate {
    
    var listPatients = NSMutableArray()
    let cellReuseIdentifier = "TSPatientCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Todd's Syndrome"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        self.navigationController?.navigationBar.tintColor = UIColor(red: 52.0/255, green: 152.0/255, blue: 219.0/255, alpha: 1.0)
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        
        let add = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(showPatientForm))
        navigationItem.rightBarButtonItems = [add]
        
        self.tableView.registerNib(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        self.tableView.tableFooterView = UIView()
        
        self.listPatients = TSUserDefaultsHelper.getListPatients()
        self.tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listPatients.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 114
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: TSPatientCell = (tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier)! as? TSPatientCell)!
        
        let patient = self.listPatients[indexPath.row] as! TSPatient
        
        cell.nameAndAgeLabel.text = patient.name + " (" + String(patient.birthDate.age) + ")"
        
        if patient.consumeDrugs ==  true {
            cell.consumeDrugsLabel.text = "YES"
        } else {
            cell.consumeDrugsLabel.text = "NO"
        }
        
        switch patient.gender {
        case "Male":
            cell.genderImageView.image = UIImage(named:"gender_male")
            break
        case "Female":
            cell.genderImageView.image = UIImage(named:"gender_female")
            break
        case "Other":
            cell.genderImageView.image = UIImage(named:"gender_ohter")
            break
        default:
            break
        }
        
        if patient.migraines ==  true {
            cell.migranesLabel.text = "YES"
        } else {
            cell.migranesLabel.text = "NO"
        }
        
        cell.percentageProbabilityLabel.text = String(patient.percentageProbability()) + "%"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            self.listPatients.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            TSUserDefaultsHelper.saveListPatients(self.listPatients)
            
            tableView.reloadData()
        }
    }
    
    //MARK: Empty state configuration
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "No Patients Submited"
        let attrs = [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let str = "Tap the button and a new patient."
        let attrs = [NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleBody)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "doctor")
    }
    
    func buttonTitleForEmptyDataSet(scrollView: UIScrollView!, forState state: UIControlState) -> NSAttributedString! {
        let str = "Add a Patient"
        let attributedString = NSAttributedString(string: str, attributes: [
            NSFontAttributeName : UIFont.systemFontOfSize(15),
            NSForegroundColorAttributeName : UIColor(red: 52.0/255, green: 152.0/255, blue: 219.0/255, alpha: 1.0)
            ])
        
        return attributedString
    }
    
    
    func emptyDataSetDidTapButton(scrollView: UIScrollView!) {
        
        showPatientForm()
    }
    
    func backgroundColorForEmptyDataSet(scrollView: UIScrollView!) -> UIColor! {
        return UIColor.whiteColor()
    }
    
    func spaceHeightForEmptyDataSet(scrollView: UIScrollView!) -> CGFloat {
        return 10
    }
    
    //MARK: Navigation
    
    func showPatientForm(){
        
        let patientForm = TSPatientForm.instanceWithDefaultNib()
        patientForm.delegate = self
        
        self.navigationController!.pushViewController(patientForm, animated: true)
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let patient = self.listPatients[indexPath.row] as! TSPatient
        
        let patientForm = TSPatientForm.instanceWithDefaultNib()
        patientForm.delegate = self
        patientForm.patient = patient
        
        self.navigationController!.pushViewController(patientForm, animated: true)
    }
    
    
    //MARK: Data Delegates
    func addPatient(patient:TSPatient){
        self.listPatients .addObject(patient)
        TSUserDefaultsHelper.saveListPatients(self.listPatients)
        self.tableView.reloadData()
    }
    
    func editPatient(patient:TSPatient){
        
        //Get the index of the patient
        if let index = TSUserDefaultsHelper.getIndexPatientInListWithDocumentNumber(patient.documentNumber) {
            self.listPatients.insertObject(patient, atIndex: index)
            
            TSUserDefaultsHelper.saveListPatients(self.listPatients)
        }
        
    }
}
