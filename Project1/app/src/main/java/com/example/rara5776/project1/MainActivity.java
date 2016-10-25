package com.example.rara5776.project1;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.text.Editable;
import android.text.TextWatcher;
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
    TextView charRemaining;

    private final int MAXNUMBER = 20;

    private final TextWatcher watchTextEdits = new TextWatcher() {
        @Override
        public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

        }

        @Override
        public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            String displayText;
            if(charSequence.length() < MAXNUMBER)
                displayText = String.valueOf("Current length is: "+charSequence.length());
            else
                displayText = String.valueOf("Max length reached: "+charSequence.length());

            charRemaining.setText(String.valueOf(displayText));

        }

        @Override
        public void afterTextChanged(Editable editable) {

        }
    };

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
        charRemaining = (TextView) findViewById(R.id.charRemaining);

        //adding listener for the EditText
        booTextField.addTextChangedListener(watchTextEdits);
    }
}
