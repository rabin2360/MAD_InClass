package com.example.rara5776.studentform;

import android.provider.MediaStore;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
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

    //view variables
    String studentGradeStr;

    public void submitButtonPressed(View view)
    {
        //submit button has been pressed
        Log.v("Name: ", studentName.getText().toString());


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
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //student text label
        studentName = (EditText) findViewById(R.id.editText);

        //spinner
        studentGrades = (Spinner)findViewById(R.id.spinner);
        studentGradeStr = String.valueOf(studentGrades.getSelectedItem());

        //toggle
        studentToggle = (ToggleButton) findViewById(R.id.toggleStudent);

        //switch
        studentSwitch = (Switch) findViewById(R.id.switch1);

        //radio group
        radioGroupVar = (RadioGroup) findViewById(R.id.radioButtonGroup);
    }

}
