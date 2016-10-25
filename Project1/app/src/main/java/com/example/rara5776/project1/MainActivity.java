package com.example.rara5776.project1;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    //variables
    Button booButton;
    TextView booLabel;
    EditText booTextField;
    ImageView image;

    public void buttonPressed(View view)
    {
        String enteredText = booTextField.getText().toString();
        booLabel.setText("Happy Halloween: "+enteredText+"!");
        //setting the source for the image
        image.setImageResource(R.drawable.ghost);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        booLabel = (TextView) findViewById(R.id.message);
        booTextField = (EditText) findViewById(R.id.enterBooText);
        image = (ImageView) findViewById(R.id.imageView);

    }
}
