package rr.helloandroid;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.Button;
import android.widget.TextView;
import android.view.View;

import org.w3c.dom.Text;

public class MainActivity extends AppCompatActivity {

    Button helloWorldButton;
    TextView displayLabel;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        //R class will assist in accesing anything in the /res folder in the project
        setContentView(R.layout.activity_main);
        displayLabel = (TextView) findViewById(R.id.displayLabel);
        helloWorldButton = (Button) findViewById(R.id.helloButton);
    }

    public void changeMessage(View view)
    {
        displayLabel.setText("Well done!");
        Log.v("test", "in here");
    }
}
