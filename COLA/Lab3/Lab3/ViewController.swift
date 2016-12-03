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
    
    @IBAction func clearFields(sender: UIButton) {

        clearFunction("buttonPress")

    }
    
    func clearFunction(clearType: String)
    {
        
        if(clearType == "buttonPress")
        {
            studentID.text = ""
        }
        studentFirstname.text = ""
        studentLastname.text = ""
        studentDOB.text = ""
        studentConsentDate.text = ""
        studentIEP.text = ""
        student401Report.text = ""
        studentPrimaryLang.text = ""
        
        //resetting the buttons as well
        studentIEPSwitch.setOn(false, animated: true)
        student401Switch.setOn(false, animated: true)
        studentConsentDateSwitch.setOn(false, animated: true)
        
        //resetting the color of the text boxes too
        colorReset(studentID)
        colorReset(studentFirstname)
        colorReset(studentLastname)
        colorReset(studentDOB)
        colorReset(studentPrimaryLang)
        colorReset(studentConsentDate)
        colorReset(studentIEP)
        colorReset(student401Report)
        
        //resetting the pickers
        self.studentEthnicity.selectRow(0, inComponent: 0, animated: false)
        self.studentGrade.selectRow(0, inComponent: 0, animated: false)
        self.studentLangProf.selectRow(0, inComponent: 0, animated: false)
    
    }
    
    func colorReset(textField:UITextField)
    {
        //resetting the color
        print("Setting stuff white")
        textField.layer.borderWidth = 0
        textField.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    func setBorderRed(textField: UITextField)
    {
        print("Setting stuff red")
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.redColor().CGColor
    }
    
    @IBAction func cancelApplication(sender: AnyObject) {
    
        //create UIAlertController object
        let alert = UIAlertController(title: "Warning", message: "Are you sure you want to exit? Unsaved info will be lost!", preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:
            {
                action in
                //exit the application if okay pressed
                UIControl().sendAction(#selector(NSURLSessionTask.suspend), to: UIApplication.sharedApplication(), forEvent: nil)

        })
        
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func validateFields() -> Bool
    {
        var validStatus = true

        if(!validateUIText(studentID))
        {
            validStatus = false
        }
        
        if(!validateUIText(studentFirstname))
        {
            validStatus = false
        }
        
        if(!validateUIText(studentLastname))
        {
            validStatus = false
        }
        
        if(!validateUIText(studentDOB))
        {
            validStatus = false
        }
        
        if(!validateUIText(studentPrimaryLang))
        {
            validStatus = false
        }
     
        if(!validateUIText(studentConsentDate))
        {
            validStatus = false
        }
    
        
        
        if(studentIEPSwitch.on)
        {
            if(!validateUIText(studentIEP))
            {
                validStatus = false
            }
        }
        
        if(student401Switch.on)
        {
            if(!validateUIText(student401Report))
            {
                validStatus = false
            }
            
        }
        
        if(studentConsentDateSwitch.on)
        {
            studentConsentDate.text = "N/A"
            studentConsentDate.enabled = false
        }
        
        return validStatus
    
    }
    
    func validateUIText(inputUIText: UITextField)->Bool
    {
        var validStatus = true
        
        if(inputUIText.text == "")
        {
            setBorderRed(inputUIText)
            validStatus = false
        }
        
        return validStatus
    }
    
    @IBAction func okPressed(sender: UIButton) {
        
        if validateFields()
        {
            print("Valid Form!")
        }
        else
        {
            print("Invalid form!")
        }
    }
    
    func datePickerValueChanged(sender: UIDatePicker)
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        studentDOB.text = dateFormatter.stringFromDate(sender.date)
    }
    
    @IBAction func enterDOB(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(ViewController.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    
    func consentDateValueChanged(sender: UIDatePicker)
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        studentConsentDate.text = dateFormatter.stringFromDate(sender.date)
    }
    
    @IBAction func enterConsent(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(ViewController.consentDateValueChanged), forControlEvents: UIControlEvents.ValueChanged)
        
    }

    @IBAction func consentDateSwitchClicked(sender: UISwitch) {
        
        if studentConsentDateSwitch.on
        {
            studentConsentDate.enabled = false
            studentConsentDate.text = "N/A"
            colorReset(studentConsentDate)

        }
        else
        {
            studentConsentDate.enabled = true
            studentConsentDate.text = ""
        }
    }
    
    @IBAction func IEPSwitchClicked(sender: UISwitch) {
    
        switchClicked(sender, textField: studentIEP)

    }

    @IBAction func SwitchClicked(sender: UISwitch) {
      
        switchClicked(sender, textField: student401Report)

    }
    
    func switchClicked(senderSwitch: UISwitch, textField: UITextField)
    {
        if(senderSwitch.on)
        {
            textField.enabled = true
        }
        else
        {
            textField.enabled = false
            textField.text = ""
            colorReset(textField)
        }
    }
    
    func enableDisableTextFields(senderSwitch: UISwitch, textField: UITextField)
    {
        if(senderSwitch.on)
        {
            textField.enabled = true
        }
        else
        {
            textField.enabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //setting the title of the page to bold
        studentPageLabel.font = UIFont.boldSystemFontOfSize(17)
        
        //reading the switches to determine the enabled states of the text fields
        enableDisableTextFields(studentIEPSwitch, textField: studentIEP)
        enableDisableTextFields(student401Switch, textField: student401Report)
        enableDisableTextFields(studentConsentDateSwitch, textField: studentConsentDate)
        
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
        firebaseRef = FIRDatabase.database().referenceFromURL("https://cola-73f9f.firebaseio.com/")
        
        //loading constants class
        constantData = Constants()
        studentData = studentInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
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
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //studentEthnicity.text = ethnicities[row]
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
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
    @IBAction func findButtonPressed(sender: UIButton) {
        var ref: FIRDatabaseReference!
        
        //check if student id is emtpy
        if let text = studentID.text where text.isEmpty
        {
            print("ERROR: Student Id field is empty")
            self.clearFunction("StudentId")
            setBorderRed(studentID)
            return
        }
        else
        {
            colorReset(studentID)
        }
        
        //getting the student info based on ID
        ref = firebaseRef.child(studentID.text!).child("student_info")
        
        ref.observeSingleEventOfType(.Value, withBlock: {
        snapshot in
            if !snapshot.exists()
            {
                self.clearFunction("StudentId")
                print("ERROR: Student Id doesn't exist")
                return
            }
            
            self.studentData.strStudentId = snapshot.childSnapshotForPath("strStudentId").value! as! String
            self.studentData.strStudentFirstname = snapshot.childSnapshotForPath("strStudentFirstname").value! as! String
            self.studentData.strStudentLastname = snapshot.childSnapshotForPath("strStudentLastname").value! as! String
            self.studentData.strStudentDOB = snapshot.childSnapshotForPath("strStudentDOB").value! as! String
            self.studentData.strStudentPrimaryLang = snapshot.childSnapshotForPath("strStudentPrimaryLang").value! as! String
            self.studentData.strStudentConsentDate = snapshot.childSnapshotForPath("strStudentConsentDate").value! as! String
            self.studentData.strStudentEthinicity = snapshot.childSnapshotForPath("strStudentEthinicity").value! as! String
            self.studentData.strStudentGradeLevel = snapshot.childSnapshotForPath("strStudentGradeLevel").value! as! String
            self.studentData.strStudentLangProficiency = snapshot.childSnapshotForPath("strStudentLangProficiency").value! as! String
            self.studentData.strStudentPrimaryDisability = snapshot.childSnapshotForPath("strStudentPrimaryDisability").value! as! String
            self.studentData.strStudentPlan504 = snapshot.childSnapshotForPath("strStudentPlan504").value! as! String
            
            //printing for debugging
            print(self.studentData)
            self.populateFormFields()
            self.setPickerView(self.studentData.strStudentEthinicity, picker: self.studentEthnicity, array: self.studentEthnicityData)
            self.setPickerView(self.studentData.strStudentGradeLevel, picker: self.studentGrade, array: self.studentGradeData)
            self.setPickerView(self.studentData.strStudentLangProficiency, picker: self.studentLangProf, array: self.studentLangProfData)
            //function to fill out all the fields
        })
        
    }
    
    func setPickerView(inputString: String, picker: UIPickerView, array: [String])
    {
        let index = array.indexOf(inputString)
        picker.selectRow(index!, inComponent: 0, animated: false)
    }

    func populateFormFields()
    {
        studentFirstname.text = self.studentData.strStudentFirstname
        studentLastname.text = self.studentData.strStudentLastname
        studentDOB.text = self.studentData.strStudentDOB
        studentPrimaryLang.text = self.studentData.strStudentPrimaryLang
        studentConsentDate.text = self.studentData.strStudentConsentDate
        //studentEthnicity.set
        
        if(!self.studentData.strStudentPrimaryDisability.isEmpty || self.studentData.strStudentPrimaryDisability != "N/A")
        {
            studentIEP.text = self.studentData.strStudentPrimaryDisability
            studentIEPSwitch.setOn(true, animated: true)
        }
        
        if(!self.studentData.strStudentPlan504.isEmpty || self.studentData.strStudentPlan504 != "N/A")
        {
            student401Report.text = self.studentData.strStudentPlan504
            student401Switch.setOn(true, animated: true)
        }
        
    }
    
    //when tapped anywhere outside the textboxes or the pickers
    //screen is dismissed
    @IBAction func ScreenTapped(sender: AnyObject) {
        
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
    @IBAction func textFieldDoneEditing(sender: UITextField)
    {
        sender.resignFirstResponder()
    }
}

