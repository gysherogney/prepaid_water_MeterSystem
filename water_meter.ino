#include <Key.h>
#include <Keypad.h>
#include <LiquidCrystal_I2C.h>
#include <HTTPClient.h>
#include "wifi_functions.h"
#include <ArduinoJson.h>
#define SENSOR  27
#define OPENWATER  25
#define CLOSEWATER  26

String apiEndpoint = "";
 
// set the LCD number of columns and rows
int lcdColumns = 16;
int lcdRows = 2;
unsigned long  balance = 0;
String meterNo = "171579844940221";
long currentMillis = 0;
long previousMillis = 0;
int interval = 100;
 float calibrationFactor = 4.5;
volatile byte pulseCount;
byte pulse1Sec = 0;
float flowRate;
unsigned int flowMilliLitres;
unsigned long totalMilliLitres;
bool openwater = false;
bool openwater_interval = 5;

 

String water_token =":";

// set LCD address, number of columns and rows
// if you don't know your display address, run an I2C scanner sketch
  
#define ROW_NUM   4 // four rows
#define COLUMN_NUM  4 // three columns

char keys[ROW_NUM][COLUMN_NUM] = {
  {'1', '2', '3', 'A'},
  {'4', '5', '6', 'B'},
  {'7', '8', '9', 'C'},
  {'*', '0', '#', 'D'}
};

byte pin_rows[ROW_NUM]      = {19, 18, 5, 17}; // GPIO19, GPIO18, GPIO5, GPIO17 connect to the row pins
byte pin_column[COLUMN_NUM] = {16, 4, 0, 2};   // GPIO16, GPIO4, GPIO0, GPIO2 connect to the column pins

Keypad keypad = Keypad( makeKeymap(keys), pin_rows, pin_column, ROW_NUM, COLUMN_NUM );
LiquidCrystal_I2C lcd(0x27, lcdColumns, lcdRows);  

void IRAM_ATTR pulseCounter()
{
  pulseCount++;
}




void setup(){
  lcd.init();
  lcd.backlight();
 

  Serial.begin(115200);
lcd.setCursor(0, 0);
  lcd.print("CONNECTING TO WIFI");
  
  // pinMode(SENSOR, INPUT_PULLUP);
  wifiSettup();
  pinMode(SENSOR, INPUT_PULLUP);
  pinMode(OPENWATER, OUTPUT);
  pinMode(CLOSEWATER, OUTPUT);

  digitalWrite(OPENWATER, LOW);
  digitalWrite(CLOSEWATER, LOW);
// Assuming meterNo is defined and initialized somewhere in your code
  String payload = "{\"meter_no\":\"" + meterNo + "\"}";
  sendHttpRequest(payload,"https://project.zepson.co.tz/api/balance","balance");
  //display balance
     lcd.clear();
   lcd.setCursor(0, 0);
  lcd.print(balance);
  lcd.setCursor(0, 1);
  lcd.print("LITRES AVAILABLE");
 // water flow sensor


  pulseCount = 0;
  flowRate = 0.0;
  flowMilliLitres = 0;
  totalMilliLitres = 0;
  previousMillis = 0;
  attachInterrupt(digitalPinToInterrupt(SENSOR), pulseCounter, FALLING);
  //water flow sensor
}

void loop() {
   Serial.begin(115200);

 
   if( openwater){
     listernWaterFlowSensor();
   }
   else{
     openwater_interval -=openwater_interval;
     if(openwater_interval==0){
     String payload = "{\"meter_no\":\"" + meterNo + "\"}";
    sendHttpRequest(payload,"https://water.zepson.co.tz/api/balance","balance");
     openwater_interval =  5;
    }
   }
 
   listernForKeyPadSensor();
 

   
}

void listernForWaterFlowSensor(){

}


 void listernForKeyPadSensor(){

  int length = water_token.length();
    char key = keypad.getKey();
        if(true){
          if(length == 1){
              // lcd.clear();
          }
          if (key) {
            water_token += key;
            Serial.println(key);
            lcd.setCursor(0, 0);
            lcd.print(String(water_token));
            // Count the length of water_token
            Serial.print("Length of water_token: ");
            Serial.println(length);
            if(length == 5){
              // lcd.setCursor(0, 1);
              // lcd.print("Loading...");
              // String message = "You entered the token: ";
              //   message +=water_token;
             // sendSMS("255622080947,255752771650", message);
              // lcd.print("SMS sent...");

            }
          }
        }
        
  
}



void sendHttpRequest(String payload,String urlpath,String tag) {
  HTTPClient http;
  http.begin(urlpath);

  // Prepare JSON payload

  // Set HTTP headers
   http.addHeader("Content-Type", "application/json");

  // Send HTTP POST request
  int httpResponseCode = http.POST(payload);

  // Check for a successful response
  if (httpResponseCode > 0) {
    Serial.print("HTTP Response code: ");
    Serial.println(httpResponseCode);
      String response = http.getString();
        Serial.println(response);
    // If you need response payload, uncomment the following line
    // String responsePayload = http.getString();
    // Serial.println(responsePayload);

    Serial.println("Response: " + response);

    // Allocate a JSON document
    // Use a size appropriate for your JSON data
    StaticJsonDocument<200> doc;

    // Parse the JSON response
    DeserializationError error = deserializeJson(doc, response);

    if (error) {
      Serial.print("deserializeJson() failed: ");
      Serial.println(error.c_str());
      return;
    }

    // Extract values from the JSON object
    bool success = doc["success"];
    const char* balanceStr  = doc["balance"];
    if(tag =="balance"){
   // Convert balance to integer
    if (balanceStr != nullptr) {
      
      balance = atoi(balanceStr);
      if(balance>0){
        openwater = true;
            digitalWrite(OPENWATER, HIGH);
            digitalWrite(CLOSEWATER, LOW);
            delay(2500);
            digitalWrite(OPENWATER, LOW);
            digitalWrite(CLOSEWATER, LOW);


      } else if(balance<=0) {
    
            digitalWrite(OPENWATER, LOW);
            digitalWrite(CLOSEWATER, HIGH);
            delay(2500);
            digitalWrite(OPENWATER, LOW);
            digitalWrite(CLOSEWATER, LOW);

              // digitalWrite(OPENWATER, LOW);
       openwater = false;
      balance = 0; // default to 0 if balance is not found or invalid
       
      }
    } 
     else if(balance<=0) {
    
            digitalWrite(OPENWATER, LOW);
            digitalWrite(CLOSEWATER, HIGH);
            delay(2500);
            digitalWrite(OPENWATER, LOW);
            digitalWrite(CLOSEWATER, LOW);

              // digitalWrite(OPENWATER, LOW);
       openwater = false;
      balance = 0; // default to 0 if balance is not found or invalid
       
      }
    }
    // lcd.clear();
    // lcd.setCursor(0, 0);
    // lcd.print(balance);
    // lcd.setCursor(0, 1);
    // lcd.print("LITRES AVAILABLE");
      if(tag =="usage"){
   // Convert balance to integer
    if (balanceStr != nullptr) {
      
      balance = atoi(balanceStr);
      if(balance>0){
        openwater = true;
          openwater = false;
            digitalWrite(OPENWATER, HIGH);
            digitalWrite(CLOSEWATER, LOW);
            delay(2500);
            digitalWrite(OPENWATER, LOW);
            digitalWrite(CLOSEWATER, LOW);
      }
      else if(balance<=0) {
      // digitalWrite(OPENWATER, LOW);
      openwater = false;
      balance = 0;
           digitalWrite(OPENWATER, LOW);
            digitalWrite(CLOSEWATER, HIGH);
            delay(2500);
            digitalWrite(OPENWATER, LOW);
            digitalWrite(CLOSEWATER, LOW);
    }
    } 
     else if(balance<=0) {
    
            digitalWrite(OPENWATER, LOW);
            digitalWrite(CLOSEWATER, HIGH);
            delay(2500);
            digitalWrite(OPENWATER, LOW);
            digitalWrite(CLOSEWATER, LOW);

              // digitalWrite(OPENWATER, LOW);
       openwater = false;
      balance = 0; // default to 0 if balance is not found or invalid
       
      }
    }
    // Print extracted values
    Serial.print("Success: ");
    Serial.println(success);
    Serial.print("Balance: ");
    Serial.println(balance);
  } else {
    Serial.print("Error in sending HTTP POST request: ");
    Serial.println(httpResponseCode);
  }

  http.end();
}

//water flow sensor

void listernWaterFlowSensor(){
 
  currentMillis = millis();
  if (currentMillis - previousMillis > interval) {
    
    pulse1Sec = pulseCount;
    pulseCount = 0;

    // Because this loop may not complete in exactly 1 second intervals we calculate
    // the number of milliseconds that have passed since the last execution and use
    // that to scale the output. We also apply the calibrationFactor to scale the output
    // based on the number of pulses per second per units of measure (litres/minute in
    // this case) coming from the sensor.
    flowRate = ((1000.0 / (millis() - previousMillis)) * pulse1Sec) / calibrationFactor;
    previousMillis = millis();

    // Divide the flow rate in litres/minute by 60 to determine how many litres have
    // passed through the sensor in this 1 second interval, then multiply by 1000 to
    // convert to millilitres.
    flowMilliLitres = (flowRate / 60) * 1000;

    // Add the millilitres passed in this second to the cumulative total
    totalMilliLitres += flowMilliLitres;

    //send api request updating server on current balance;
    if(totalMilliLitres != 0 && totalMilliLitres>100 ){
          balance = (balance*1000) - (totalMilliLitres/1000);
          if(balance<=0){
             openwater = false;
            digitalWrite(OPENWATER, LOW);
            digitalWrite(CLOSEWATER, HIGH);
            delay(3500);
            digitalWrite(OPENWATER, HIGH);
            digitalWrite(CLOSEWATER, HIGH);
            
          }
          balance = balance/1000;

      //update usage
    String payload = "{\"meter_no\":\"" + meterNo + "\",\"usage\":" + String(totalMilliLitres) + "}";
    sendHttpRequest(payload,"https://water.zepson.co.tz/api/usage","usage");
    totalMilliLitres = 0;
    }
    // Print the flow rate for this second in litres / minute
    Serial.print("Flow rate: ");
    Serial.print(int(flowRate));  // Print the integer part of the variable
    Serial.print("L/min");
    Serial.print("\t");       // Print tab space

    // Print the cumulative total of litres flowed since starting
    Serial.print("Available balance: ");
    Serial.print(balance);
    Serial.print("Litres / ");

    // lcd.clear();
    // lcd.setCursor(0, 0);
    // lcd.print(balance);
    //  lcd.setCursor(0, 1);
    //   lcd.print("AVAILABLE BALANCE");
    Serial.print(balance);
    Serial.println("L");
    
 
  }
}

 

