
#include "wifi_functions.h"
const char* ssid     = "mihayo";
const char* password = "12345678";



void wifiSettup(){
  //connection attempt
  WiFi.begin(ssid, password);
      // lcd.print("Please wait...");

    Serial.println();
    Serial.println();
    Serial.print("Connecting to ");
//listerning for status
    while (WiFi.status() != WL_CONNECTED) {
      delay(500);
      Serial.print(".");
  }

//connected
     Serial.println("");
    Serial.println("WiFi connected.");
    Serial.println("IP address: ");
    Serial.println(WiFi.localIP());
      // lcd.clear();
    // lcd.setCursor(0, 0);
    // lcd.print("YOUR ONLINE");
    Serial.print("YOUR ONLINE");

}