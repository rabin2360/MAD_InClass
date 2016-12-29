//
//  StudentUtil.swift
//  COLA
//
//  Created by Rabin Ranabhat on 12/28/16.
//  Copyright © 2016 Rabin Ranabhat. All rights reserved.
//

import Foundation
import UIKit

class StudentUtil
{

    //resetting the border color for UITextField
    func utilColorReset(_ textField: UITextField)
    {
        //resetting the color
        textField.layer.borderWidth = 0
        textField.layer.borderColor = UIColor.white.cgColor
    }
    
    //sets the UITextField borders to red
    func utilSetBorderRed(_ textField: UITextField)
    {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.red.cgColor
    }
    
    //validate the UI Text field i.e. makes sure there is an entry
    func utilValidateUIText(_ inputUIText: UITextField)->Bool
    {
        var validStatus = true
        
        if(inputUIText.text == "")
        {
            utilSetBorderRed(inputUIText)
            validStatus = false
        }
        else
        {
            utilColorReset(inputUIText)
        }
        
        return validStatus
    }
    
    //returns date in the format YYYY/MM/DD
    func utilDatePickerFormat_YYYY_MM_DD(_ sender: UIDatePicker) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        
        let date = dateFormatter.string(from: sender.date)
        var dateArray = date.components(separatedBy: "-")
        
        let selectedDate = dateArray[0]
        var mm_dd_yy_array = selectedDate.components(separatedBy: "/")
        let day_int:Int? = Int(mm_dd_yy_array[1])
        let month_int:Int? = Int(mm_dd_yy_array[0])
        let day = String(format: "%02d", day_int!)
        let month = String(format: "%02d", month_int!)
        
        /*DEBUG
         print("day \(day)")
         print("month \(month)")
         print("date array \(dateArray)")
         print("date array \(mm_dd_yy_array)")
         */
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        let yearStr = dateFormatter.string(from: sender.date)
        var yearStrArray = yearStr.components(separatedBy: " ,")
        var yearDataArray = yearStrArray[0].components(separatedBy: ",")
        print("year date \(yearStrArray)")
        
        return yearDataArray[1]+"/"+month+"/"+day
    }
    
    //function to enable or disable UITextfields
    func utilEnableDisableTextFields(_ senderSwitch: UISwitch, textField: UITextField)
    {
        if(senderSwitch.isOn)
        {
            textField.isEnabled = true
        }
        else
        {
            textField.isEnabled = false
        }
    }
    
    //function where hex value can be supplied for color i.e. 0xEFECCA for color
    func utilUIColorFromHex(_ rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    //sets the switch to white border and also covers the round edges
    func utilSetSwitchToWhite(_ switchButton: UISwitch)
    {
        switchButton.backgroundColor = UIColor.white
        switchButton.layer.cornerRadius = 16.0
    }
    
    //sets the display for the picker
    func utilSetPickerView(_ inputString: String, picker: UIPickerView, array: [String])
    {
        let index = array.index(of: inputString)
        if(index != nil)
        {
            picker.selectRow(index!, inComponent: 0, animated: false)
        }
        else
        {
            picker.selectRow(0, inComponent: 0, animated: false)
        }
    }
}
