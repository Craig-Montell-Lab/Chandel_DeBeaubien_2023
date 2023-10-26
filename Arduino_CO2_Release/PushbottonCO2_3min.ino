
int ledPin = 5;
int buttonpin = 9;
int buttonpin2 = 11;
int toggle = 1;
int val = 0;
int timeAdjustment = 25;

const int numReadings = 10;

int readings[] = {100, 100, 100, 100, 100, 100, 100, 100, 100, 100};
int readIndex = 0;
int total = 0;
int average = 0;  

int readings2[] = {100, 100, 100, 100, 100, 100, 100, 100, 100, 100};
int readIndex2 = 0;
int total2 = 0;
int average2 = 0; 

// toggle = 1 LED On
// toggle = 2 LED Off

void setup()  
  {
  pinMode(ledPin, OUTPUT);
  pinMode(buttonpin, INPUT_PULLUP);
  pinMode(buttonpin2, INPUT_PULLUP);
  digitalWrite(ledPin, HIGH);
  Serial.begin(9600);
  }

void loop()
  {
  digitalWrite(ledPin, HIGH);
  readings[readIndex] = digitalRead(buttonpin)*100;   // take the resding from the pin and assign to array
  readings2[readIndex] = digitalRead(buttonpin2)*100;
  readIndex = readIndex + 1;                          // advance one in the array

 
  if  (readIndex >= numReadings) {                    // return to top of array when bottom is reached
      readIndex = 0;
      }

total =   readings[0] + readings[1] + readings[2] +   // calculate the total for the window
          readings[3] + readings[4] + readings[5] + 
          readings[6] + readings[7] + readings[8] + 
          readings[9];     
           
total2 =  readings2[0] + readings2[1] + readings2[2] +   // calculate the total for the window
          readings2[3] + readings2[4] + readings2[5] + 
          readings2[6] + readings2[7] + readings2[8] + 
          readings2[9];  
          
//Serial.println("TOTAL:");
//Serial.println(total);
average = total / 10;                                 // calculate the average for the digitalpin
average2 = total2/10;
 //  Serial.println("ARRAY:");                          // print window pin values to serial window
  
 // for (int i = 0; i < numReadings; i++)               //
  //    {
  //    Serial.println(readings[i]);                    //
  //    }
  //    Serial.println("TOTAL");                        //
  //    Serial.println(total,DEC);                      //
 //     delay(timeAdjustment);                          //

   if (average < 80)
   {
  Serial.println("Exp Start");  
  Serial.println("CO2 ON");   
     readings[0] = 100;
      readings[1] = 100;
      readings[2] = 100;
      readings[3] = 100;
      readings[4] = 100;
      readings[5] = 100;
      readings[6] = 100;
      readings[7] = 100;
      readings[8] = 100;
      readings[9] = 100;
      readIndex = 0;
      total = 1000;
      average = 100;
      
    digitalWrite(ledPin, LOW);              // Minute 1
    delay(30000);
    digitalWrite(ledPin, HIGH);
   Serial.println("CO2 OFF");
    delay(20000);
    digitalWrite(ledPin, LOW);
  Serial.println("CO2 ON");
    delay(10000);
    digitalWrite(ledPin, HIGH);             // Minute 2
  Serial.println("CO2 OFF");
    delay(50000);
    digitalWrite(ledPin, LOW);
  Serial.println("CO2 ON");
    delay(10000);
    digitalWrite(ledPin, HIGH);             // Minute 3
  Serial.println("CO2 OFF");           
    delay(50000);
    digitalWrite(ledPin, LOW);
 Serial.println("CO2 ON");
    delay(10000);  
    digitalWrite(ledPin, HIGH);             // Minute 4
  Serial.println("CO2 OFF");
   
                     
Serial.println("CO2 OFF");    
Serial.println("Loop Complete");  
      readings[0] = 100;
      readings[1] = 100;
      readings[2] = 100;
      readings[3] = 100;
      readings[4] = 100;
      readings[5] = 100;
      readings[6] = 100;
      readings[7] = 100;
      readings[8] = 100;
      readings[9] = 100;
      readIndex = 0;
      total = 1000;
      average = 100;

      readings2[0] = 100;
      readings2[1] = 100;
      readings2[2] = 100;
      readings2[3] = 100;
      readings2[4] = 100;
      readings2[5] = 100;
      readings2[6] = 100;
      readings2[7] = 100;
      readings2[8] = 100;
      readings2[9] = 100;
      readIndex = 0;
      total2 = 1000;
      average2 = 100;
   }

   if (average2 < 80)
   {digitalWrite(ledPin, LOW);             
    Serial.println("CO2 ON");
    delay(90000);
    digitalWrite(ledPin, HIGH);
    Serial.println("CO2 OFF");    
      readings[0] = 100;
      readings[1] = 100;
      readings[2] = 100;
      readings[3] = 100;
      readings[4] = 100;
      readings[5] = 100;
      readings[6] = 100;
      readings[7] = 100;
      readings[8] = 100;
      readings[9] = 100;
      readIndex = 0;
      total = 1000;
      average = 100;

      readings2[0] = 100;
      readings2[1] = 100;
      readings2[2] = 100;
      readings2[3] = 100;
      readings2[4] = 100;
      readings2[5] = 100;
      readings2[6] = 100;
      readings2[7] = 100;
      readings2[8] = 100;
      readings2[9] = 100;
      readIndex = 0;
      total2 = 1000;
      average2 = 100;
   }
  }                                                     
