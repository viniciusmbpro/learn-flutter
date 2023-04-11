#include <AFMotor.h>
#include <SoftwareSerial.h>

SoftwareSerial bluetooth(A1, A0);

#define FORWARD 2
#define BACKWARD 1

AF_DCMotor motor1(1);
AF_DCMotor motor2(2);
AF_DCMotor motor3(3);
AF_DCMotor motor4(4);

void setup() {
  bluetooth.begin(9600);

  motor1.setSpeed(0);
  motor2.setSpeed(0);
  motor3.setSpeed(0);
  motor4.setSpeed(0);

  motor1.run(RELEASE);
  motor2.run(RELEASE);
  motor3.run(RELEASE);
  motor4.run(RELEASE);
}

void loop() {
  while (bluetooth.available()) {
    String comando = bluetooth.readString();

    if(comando.length() == 2) {
      if(comando.substring(0,1) == "F") {
        int velocidade = comando.substring(1).toInt();
        moverFrente(velocidade);
      }
      else if(comando.substring(0,1) == "B") {
        int velocidade = comando.substring(1).toInt();
        moverTras(velocidade);
      }
    }
    else if(comando.substring(0,2) == "FR") {
      int velocidade = comando.substring(2).toInt();
      moverDireitaFrente(velocidade);
    }
    else if(comando.substring(0,2) == "FL") {
      int velocidade = comando.substring(2).toInt();
      moverEsquerdaFrente(velocidade);
    }
    else if(comando.substring(0,2) == "BR") {
      int velocidade = comando.substring(2).toInt();
      moverDireitaTras(velocidade);
    }
    else if(comando.substring(0,2) == "BL") {
      int velocidade = comando.substring(2).toInt();
      moverEsquerdaTras(velocidade);
    }
    else if(comando == "giro") {
      girar();
      comando = "S0";
    }
    else if(comando == "insp") {
      inspecionar();
      comando = "S0";
    }
    else {
      ficarParado();
    }
  }
}

void moverFrente(int velocidade) {
  int speed = 255 / 6 * velocidade;
  motor1.run(FORWARD);
  motor2.run(FORWARD);
  motor3.run(FORWARD);
  motor4.run(FORWARD);
  motor1.setSpeed(speed);
  motor2.setSpeed(speed);
  motor3.setSpeed(speed);
  motor4.setSpeed(speed);
}

void moverTras(int velocidade) {
  int speed = 255 / 6 * velocidade;
  motor1.run(BACKWARD);
  motor2.run(BACKWARD);
  motor3.run(BACKWARD);
  motor4.run(BACKWARD);
  motor1.setSpeed(speed);
  motor2.setSpeed(speed);
  motor3.setSpeed(speed);
  motor4.setSpeed(speed);
}

void moverDireitaFrente(int velocidade) {
  int speed = 255 / 6 * velocidade;
  motor3.run(FORWARD);
  motor2.run(FORWARD);
  motor1.run(RELEASE);
  motor4.run(RELEASE);
  motor2.setSpeed(speed);
  motor3.setSpeed(speed);
}

void moverEsquerdaFrente(int velocidade) {
  int speed = 255 / 6 * velocidade;
  motor3.run(RELEASE);
  motor2.run(RELEASE);
  motor1.run(FORWARD);
  motor4.run(FORWARD);
  motor1.setSpeed(speed);
  motor4.setSpeed(speed);
}
void moverDireitaTras(int velocidade) {
  int speed = 255 / 6 * velocidade;
  motor3.run(BACKWARD);
  motor2.run(BACKWARD);
  motor1.run(RELEASE);
  motor4.run(RELEASE);
  motor2.setSpeed(speed);
  motor3.setSpeed(speed);
}

void moverEsquerdaTras(int velocidade) {
  int speed = 255 / 6 * velocidade;
  motor3.run(RELEASE);
  motor2.run(RELEASE);
  motor1.run(BACKWARD);
  motor4.run(BACKWARD);
  motor1.setSpeed(speed);
  motor4.setSpeed(speed);
}

void ficarParado() {
  motor1.run(RELEASE);
  motor2.run(RELEASE);
  motor3.run(RELEASE);
  motor4.run(RELEASE);
  motor1.setSpeed(0);
  motor2.setSpeed(0);
  motor3.setSpeed(0);
  motor4.setSpeed(0);
}

void girar() {
  motor1.run(FORWARD);
  motor2.run(FORWARD);
  motor3.run(RELEASE);
  motor4.run(RELEASE);
  motor1.setSpeed(255);
  motor2.setSpeed(255);
  motor3.setSpeed(0);
  motor4.setSpeed(0);
  delay(2000);
}

void inspecionar() {
  moverFrente(100);
  delay(1000);

  moverDireitaFrente(100);
  delay(1000);

  moverFrente(100);
  delay(1000);

  moverDireitaFrente(100);
  delay(1000);

  moverFrente(100);
  delay(1000);
}
