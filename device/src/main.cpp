#include <Arduino.h>
#include "Keyboard.h"

#define rep(i,n) for(int i=0;i<n;i++)

const int cnt = 8;
const int pins[] = {2,3,4,5,9,11,13,14};
const char keys[] = {'w','s','a','d',' ','f',KEY_LEFT_CTRL,KEY_LEFT_SHIFT};;

void setup() {
  Keyboard.begin();
  rep(i,cnt)pinMode(pins[i],INPUT_PULLUP);
}

void loop() {
  rep(i,cnt){
    if(digitalRead(pins[i]) == LOW) Keyboard.press(keys[i]);
    else Keyboard.release(keys[i]);
  }
}