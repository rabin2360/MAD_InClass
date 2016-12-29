//
//  ViewController.swift
//  Lab3
//
//  Created by Rabin Ranabhat on 9/23/16.
//  Copyright © 2016 Rabin Ranabhat. All rights reserved.
//

import UIKit
import QuartzCore
import Firebase

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var studentID: UITextField!
    @IBOutlet weak var studentFirstname: UITextField!
    @IBOutlet weak var studentLastname: UITextField!
    @IBOutlet weak var studentPageLabel: UILabel!
    @IBOutlet weak var studentDOB: UITextField!
    @IBOutlet weak var studentPrimaryLang: UITextField!
    @IBOutlet weak var studentConsentDate: UITextField!
    @IBOutlet weak var studentIEP: UITextField!
    @IBOutlet weak var studentIEPSwitch: UISwitch!
    @IBOutlet weak var student401Report: UITextField!
    @IBOutlet weak var student401Switch: UISwitch!
    @IBOutlet weak var studentConsentDateSwitch: UISwitch!
    
    @IBOutlet weak var studentEthnicity: UIPickerView!
    @IBOutlet weak var studentGrade: UIPickerView!
    @IBOutlet weak var studentLangProf: UIPickerView!
    
    var studentEthnicityData : [String] = [String]()
    var studentGradeData : [String] = [String]()
    var studentLangProfData : [String] = [String]()
    
    //firebase
    var firebaseRef : FIRDatabaseReference!
    
    //reference to constants class
    var constantData : Constants!
    
    var studentFormUtil: StudentUtil!
    
    struct studentInfo
    {
        var strStudentId = "N/A"
        var strStudentFirstname = "N/A"
        var strStudentLastname = "N/A"
        var strStudentDOB = "N/A"
        var strStudentPrimaryLang = "N/A"
        var strStudentConsentDate = "N/A"
        var strStudentEthinicity = "N/A"
        var strStudentGradeLevel = "N/A"
        var strStudentLangProficiency = "N/A"
        var strStudentPrimaryDisability = "N/A"
        var strStudentPlan504 = "N/A"
    }
    
    var studentData : studentInfo!
    
    @IBAction func clearFields(_ sender: UIButton) {

        clearFunction("buttonPress")

    }
    
    func clearFunction(_ clearType: String)
    {
        
        if(clearType == "buttonPress")
        {
            studentID.text = ""
        }
        studentFirstname.text = ""
        studentLastname.text = ""
        studentDOB.text = ""
        
        studentConsentDate.text = ""
        studentConsentDate.isEnabled = true
        
        studentIEP.text = ""
        student401Report.text = ""
        studentPrimaryLang.text = ""
        
        //resetting the buttons as well
        studentIEPSwitch.setOn(false, animated: true)
        student401Switch.setOn(false, animated: true)
        studentConsentDateSwitch.setOn(false, animated: true)
        
        //resetting the color of the text boxes too
        studentFormUtil.utilColorReset(studentID)
        studentFormUtil.utilColorReset(studentFirstname)
        studentFormUtil.utilColorReset(studentLastname)
        studentFormUtil.utilColorReset(studentDOB)
        studentFormUtil.utilColorReset(studentPrimaryLang)
        studentFormUtil.utilColorReset(studentConsentDate)
        studentFormUtil.utilColorReset(studentIEP)
        studentFormUtil.utilColorReset(student401Report)
        
        //resetting the pickers
        self.studentEthnicity.selectRow(0, inComponent: 0, animated: false)
        self.studentGrade.selectRow(0, inComponent: 0, animated: false)
        self.studentLangProf.selectRow(0, inComponent: 0, animated: false)
    
    }
    
    
    @IBAction func cancelApplication(_ sender: AnyObject) {
    
        //create UIAlertController object
        let alert = UIAlertController(title: "Warning", message: "Are you sure you want to exit? Unsaved info will be lost!", preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:
            {
                action in
                //exit the application if okay pressed
                UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)

        })
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func validateFields() -> Bool
    {
        
        var validStatus = true

        if(!studentFormUtil.utilValidateUIText(studentID))
        {
            validStatus = false
        }
        
        if(!studentFormUtil.utilValidateUIText(studentFirstname))
        {
            validStatus = false
        }
        
        if(!studentFormUtil.utilValidateUIText(studentLastname))
        {
            validStatus = false
        }
        
        if(!studentFormUtil.utilValidateUIText(studentDOB))
        {
            validStatus = false
        }
        
        if(!studentFormUtil.utilValidateUIText(studentPrimaryLang))
        {
            validStatus = false
        }
     
        if(!studentFormUtil.utilValidateUIText(studentConsentDate))
        {
            validStatus = false
        }
    
        
        
        if(studentIEPSwitch.isOn)
        {
            if(!studentFormUtil.utilValidateUIText(studentIEP))
            {
                validStatus = false
            }
        }
        
        if(student401Switch.isOn)
        {
            if(!studentFormUtil.utilValidateUIText(student401Report))
            {
                validStatus = false
            }
            
        }
        
        if(studentConsentDateSwitch.isOn)
        {
            studentConsentDate.text = "N/A"
            studentConsentDate.isEnabled = false
        }
        
        return validStatus
    
    }
    
    @IBAction func okPressed(_ sender: UIButton) {
        
        if validateFields()
        {
            print("Valid Form!")
            
            //save to firebase here!
            self.studentData.strStudentId = studentID.text!
            self.studentData.strStudentFirstname = studentFirstname.text!
            self.studentData.strStudentLastname = studentLastname.text!
            self.studentData.strStudentDOB = studentDOB.text!
            self.studentData.strStudentPrimaryLang = studentPrimaryLang.text!
            self.studentData.strStudentConsentDate = studentConsentDate.text!
            
            if(studentIEPSwitch.isOn)
            {
                self.studentData.strStudentPrimaryDisability = studentIEP.text!
            }
            else
            {
                self.studentData.strStudentPrimaryDisability = "N/A"
            }
            
            if(student401Switch.isOn)
            {
                self.studentData.strStudentPlan504 = student401Report.text!
            }
            else
            {
                self.studentData.strStudentPlan504 = "N/A"
            }
            
            print("Data to save \(studentData)")
           
            //make the data dictionary
            let studentDict: [String:String] =
                [constantData.ID:self.studentData.strStudentId,
                 constantData.FIRSTNAME:self.studentData.strStudentFirstname,
                 constantData.LASTNAME: self.studentData.strStudentLastname,
                 constantData.DOB:self.studentData.strStudentDOB,
                 constantData.CONSENT_DATE: self.studentData.strStudentConsentDate,
                 constantData.PRIMARY_LANG:self.studentData.strStudentPrimaryLang,
                 constantData.ETHNICITY:self.studentData.strStudentEthinicity,
                 constantData.GRADE:self.studentData.strStudentGradeLevel,
                 constantData.LANG_PROF:self.studentData.strStudentLangProficiency,
                 constantData.PRIMARY_DISABILITY:self.studentData.strStudentPrimaryDisability,
                 constantData.PLAN_504:self.studentData.strStudentPlan504]
            
            let studentInfoRef = self.firebaseRef.child(self.studentData.strStudentId).child("student_info")
            studentInfoRef.setValue(studentDict)
            
            showAlert("Saving/Updating Successful!", message: "Successfully saved/updated data to firebase!", dismissMsg: "OK")
        }
        else
        {
            print("Invalid form!")
            showAlert("Missing Required Fields!", message: "Required fields are missing. Please fill the fields marked in red.", dismissMsg: "OK")
        }
    }
    
    func datePickerValueChanged(_ sender: UIDatePicker)
    {
        studentDOB.text = ""
        studentDOB.text = studentFormUtil.utilDatePickerFormat_YYYY_MM_DD(sender)
    }
    
    @IBAction func enterDOB(_ sender: UITextField) {
        studentDOB.text = ""
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(ViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
    }
    
    func consentDateValueChanged(_ sender: UIDatePicker)
    {
        studentConsentDate.text = ""
        studentConsentDate.text = studentFormUtil.utilDatePickerFormat_YYYY_MM_DD(sender)
    }
    
    @IBAction func enterConsent(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(ViewController.consentDateValueChanged), for: UIControlEvents.valueChanged)
        
    }

    @IBAction func consentDateSwitchClicked(_ sender: UISwitch) {
        
        if studentConsentDateSwitch.isOn
        {
            studentConsentDate.isEnabled = false
            studentConsentDate.text = "N/A"
            studentFormUtil.utilColorReset(studentConsentDate)

        }
        else
        {
            studentConsentDate.isEnabled = true
            studentConsentDate.text = ""
        }
    }
    
    @IBAction func IEPSwitchClicked(_ sender: UISwitch) {
    
        switchClicked(sender, textField: studentIEP)

    }

    @IBAction func SwitchClicked(_ sender: UISwitch) {
      
        switchClicked(sender, textField: student401Report)

    }
    
    func switchClicked(_ senderSwitch: UISwitch, textField: UITextField)
    {
        if(senderSwitch.isOn)
        {
            textField.isEnabled = true
        }
        else
        {
            textField.isEnabled = false
            textField.text = ""
            studentFormUtil.utilColorReset(textField)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //init util function class
        studentFormUtil = StudentUtil()
        
        //setting the title of the page to bold
        studentPageLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        //setting the app color themes
        self.view.backgroundColor = studentFormUtil.utilUIColorFromHex(0xEFECCA)
        studentFormUtil.utilSetSwitchToWhite(studentConsentDateSwitch)
        studentFormUtil.utilSetSwitchToWhite(studentIEPSwitch)
        studentFormUtil.utilSetSwitchToWhite(student401Switch)
        
        studentLangProf.backgroundColor = UIColor.white
        studentEthnicity.backgroundColor = UIColor.white
        studentGrade.backgroundColor = UIColor.white
        
        //reading the switches to determine the enabled states of the text fields
        studentFormUtil.utilEnableDisableTextFields(studentIEPSwitch, textField: studentIEP)
        studentFormUtil.utilEnableDisableTextFields(student401Switch, textField: student401Report)
        studentFormUtil.utilEnableDisableTextFields(studentConsentDateSwitch, textField: studentConsentDate)
        
        let ethnicityPicker = UIPickerView()
        ethnicityPicker.delegate = self
        ethnicityPicker.dataSource = self
        //studentEthnicity.inputView = ethnicityPicker

        //connecting the pickers to data
        self.studentEthnicity.delegate = self
        self.studentEthnicity.dataSource = self
       
        self.studentGrade.delegate = self
        self.studentGrade.delegate = self
        
        self.studentLangProf.delegate = self
        self.studentLangProf.delegate = self
        
        studentEthnicityData = ["Select Ethnicity", "White", "African American", "Asian", "Other"]
        studentGradeData = ["Select Grade","Pre-K", "K", "1","2", "12"]
        studentLangProfData = ["Select Proficiency","Proficient", "Not Proficient"]
        
        //firebase 
        firebaseRef = FIRDatabase.database().reference(fromURL: "https://cola-73f9f.firebaseio.com/")
        
        //loading constants class
        constantData = Constants()
        studentData = studentInfo()
        
        //clear all the fields
        clearFunction("buttonPress")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if(pickerView == studentEthnicity)
        {
            return studentEthnicityData.count
        }
        else if(pickerView == studentGrade)
        {
            return studentGradeData.count
        }
        else if(pickerView == studentLangProf)
        {
            return studentLangProfData.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //studentEthnicity.text = ethnicities[row]
        if(pickerView == studentEthnicity)
        {
            self.studentData.strStudentEthinicity = studentEthnicityData[row]
        }
        else if(pickerView == studentGrade)
        {
            self.studentData.strStudentGradeLevel = studentGradeData[row]
        }
        else if(pickerView == studentLangProf)
        {
            self.studentData.strStudentLangProficiency = studentLangProfData[row]
        }
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(pickerView == studentEthnicity)
        {
            return 	studentEthnicityData[row]
        }
        else if(pickerView == studentGrade)
        {
            return studentGradeData[row]
        }
        else if(pickerView == studentLangProf)
        {
            return studentLangProfData[row]
        }
        
        return ""
    }

    //TODO: Continue working on this...
    @IBAction func findButtonPressed(_ sender: UIButton) {
        var ref: FIRDatabaseReference!
        
        //check if student id is emtpy
        if let text = studentID.text, text.isEmpty
        {
            print("ERROR: Student Id field is empty")
            showAlert("Student ID Needed!", message: "Please enter the student Id.", dismissMsg: "OK")
            self.clearFunction("StudentId")
            
            studentFormUtil.utilSetBorderRed(studentID)
            return
        }
        else
        {
            //colorReset(studentID)
            studentFormUtil.utilColorReset(studentID)
            studentFormUtil.utilColorReset(studentFirstname)
            studentFormUtil.utilColorReset(studentLastname)
            studentFormUtil.utilColorReset(studentPrimaryLang)
            studentFormUtil.utilColorReset(studentDOB)
            studentFormUtil.utilColorReset(studentConsentDate)
            
            if(studentIEPSwitch.isOn)
            {
             studentFormUtil.utilColorReset(studentIEP)
            }
            
            if(student401Switch.isOn)
            {
             studentFormUtil.utilColorReset(student401Report)
            }
        }
        
        //getting the student info based on ID
        ref = firebaseRef.child(studentID.text!).child("student_info")
        
        ref.observeSingleEvent(of: .value, with: {
        snapshot in
            if !snapshot.exists()
            {
                self.clearFunction("StudentId")
                self.showAlert("Student Id Not Found!", message: "Student Id not found in the database.", dismissMsg: "OK")
                print("ERROR: Student Id doesn't exist")
                return
            }
            
            self.studentData.strStudentId = snapshot.childSnapshot(forPath: "strStudentId").value! as! String
            self.studentData.strStudentFirstname = snapshot.childSnapshot(forPath: "strStudentFirstname").value! as! String
            self.studentData.strStudentLastname = snapshot.childSnapshot(forPath: "strStudentLastname").value! as! String
            self.studentData.strStudentDOB = snapshot.childSnapshot(forPath: "strStudentDOB").value! as! String
            self.studentData.strStudentPrimaryLang = snapshot.childSnapshot(forPath: "strStudentPrimaryLang").value! as! String
            self.studentData.strStudentConsentDate = snapshot.childSnapshot(forPath: "strStudentConsentDate").value! as! String
            self.studentData.strStudentEthinicity = snapshot.childSnapshot(forPath: "strStudentEthinicity").value! as! String
            self.studentData.strStudentGradeLevel = snapshot.childSnapshot(forPath: "strStudentGradeLevel").value! as! String
            self.studentData.strStudentLangProficiency = snapshot.childSnapshot(forPath: "strStudentLangProficiency").value! as! String
            self.studentData.strStudentPrimaryDisability = snapshot.childSnapshot(forPath: "strStudentPrimaryDisability").value! as! String
            self.studentData.strStudentPlan504 = snapshot.childSnapshot(forPath: "strStudentPlan504").value! as! String
            
            //printing for debugging
            print(self.studentData)
            self.populateFormFields()
            self.studentFormUtil.utilSetPickerView(self.studentData.strStudentEthinicity, picker: self.studentEthnicity, array: self.studentEthnicityData)
            self.studentFormUtil.utilSetPickerView(self.studentData.strStudentGradeLevel, picker: self.studentGrade, array: self.studentGradeData)
            self.studentFormUtil.utilSetPickerView(self.studentData.strStudentLangProficiency, picker: self.studentLangProf, array: self.studentLangProfData)
            //function to fill out all the fields
        })
        
    }
    
    func populateFormFields()
    {
        studentFirstname.text = self.studentData.strStudentFirstname
        studentLastname.text = self.studentData.strStudentLastname
        studentDOB.text = self.studentData.strStudentDOB
        studentPrimaryLang.text = self.studentData.strStudentPrimaryLang
        
        if(self.studentData.strStudentConsentDate != "N/A")
        {
            studentConsentDate.text = self.studentData.strStudentConsentDate
            studentConsentDate.isEnabled = true
        }
        else
        {
            studentConsentDateSwitch.setOn(true, animated: true)
            studentConsentDate.text = "N/A"
            studentConsentDate.isEnabled = false
        }
        
        if(!self.studentData.strStudentPrimaryDisability.isEmpty || self.studentData.strStudentPrimaryDisability != "N/A")
        {
            studentIEP.text = self.studentData.strStudentPrimaryDisability
            studentIEP.isEnabled = true
            studentIEPSwitch.setOn(true, animated: true)
            
        }
        
        if(!self.studentData.strStudentPlan504.isEmpty || self.studentData.strStudentPlan504 != "N/A")
        {
            student401Report.text = self.studentData.strStudentPlan504
            student401Switch.setOn(true, animated: true)
            student401Report.isEnabled = true
        }
        
    }
    
    func showAlert(_ title:String, message:String, dismissMsg:String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: dismissMsg, style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //when tapped anywhere outside the textboxes or the pickers
    //screen is dismissed
    @IBAction func ScreenTapped(_ sender: AnyObject) {
        
        if studentID != nil
        {
            studentID.resignFirstResponder()
        }
        
        if studentFirstname != nil
        {
            studentFirstname.resignFirstResponder()
        }
        
        if studentLastname != nil
        {
            studentLastname.resignFirstResponder()
        }
        
        studentDOB.resignFirstResponder()
        studentLangProf.resignFirstResponder()
        studentEthnicity.resignFirstResponder()
        studentGrade.resignFirstResponder()
        studentPrimaryLang.resignFirstResponder()
        studentConsentDate.resignFirstResponder()
        student401Report.resignFirstResponder()
        studentIEP.resignFirstResponder()
    }
    
    //this will listen to all the text fields and then resign the control to keyboard when 'DONE' is tapped
    @IBAction func textFieldDoneEditing(_ sender: UITextField)
    {
        sender.resignFirstResponder()
    }
}

