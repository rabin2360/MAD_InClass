package com.example.rara5776.studentform;

import android.provider.MediaStore;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.RadioGroup;
import android.widget.Spinner;
import android.view.View;
import android.widget.Switch;
import android.widget.ToggleButton;

public class MainActivity extends AppCompatActivity {

    EditText studentName;
    Spinner studentGrades;
    ToggleButton studentToggle;
    Switch studentSwitch;
    RadioGroup radioGroupVar;
    CheckBox checkBox1;
    CheckBox checkBox2;

    //view variables
    String studentGradeStr;

    public void submitButtonPressed(View view)
    {
        //submit button has been pressed
        Log.v("Name: ", studentName.getText().toString());

        studentGradeStr = String.valueOf(studentGrades.getSelectedItem());
        Log.v("Student Grade: ", studentGradeStr);

        //processing the toggle button
        String toggleString;

        if(studentToggle.isChecked())
        {
            toggleString = studentToggle.getTextOn().toString();
        }
        else
        {
            toggleString = studentToggle.getTextOff().toString();
        }

        Log.v("Toggle: ", toggleString);

        //switches
        String switchString = "";
        boolean studentSwitchBool = studentSwitch.isChecked();

        if(studentSwitchBool)
        {
            switchString = "Switch is on";
        }
        else
        {
            switchString = "Switch is off";
        }

        Log.v("Switch:", switchString);

        //radio buttons group
        String radioButtonType = "";
        int radioButtonId = radioGroupVar.getCheckedRadioButtonId();

        switch(radioButtonId)
        {
            case -1:
                radioButtonType = "Not defined";
                break;

            case R.id.firstButton:
                radioButtonType = "firstButton";
                break;

            case R.id.secondButton:
                radioButtonType = "secondButton";
                break;

            default:
                radioButtonType = "error";
        }

        Log.v("Radio Button Type:", radioButtonType);

        boolean check1 = checkBox1.isChecked();
        boolean check2 = checkBox2.isChecked();

        if(check1)
        {
            Log.v("Check1:", "is enabled" );
        }

        if(check2)
        {
            Log.v("Check2: ", "is enabled");
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //student text label
        studentName = (EditText) findViewById(R.id.editText);

        //spinner
        studentGrades = (Spinner)findViewById(R.id.spinner);

        //toggle
        studentToggle = (ToggleButton) findViewById(R.id.toggleStudent);

        //switch
        studentSwitch = (Switch) findViewById(R.id.switch1);

        //radio group
        radioGroupVar = (RadioGroup) findViewById(R.id.radioButtonGroup);

        //check box 1
        checkBox1 = (CheckBox)findViewById(R.id.checkBox);

        //check box 2
        checkBox2 = (CheckBox) findViewById(R.id.checkBox2);
    }

}
