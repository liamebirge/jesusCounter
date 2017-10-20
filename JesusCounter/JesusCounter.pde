import java.io.BufferedWriter;
import java.io.FileWriter;

int timesPreached, day, month, year, bttn1, bttn2, bttn1Stroke, bttn2Stroke;
String date;
PImage jesus;
Boolean write, checkin;
String timeArrived, timeLate;

void setup(){
  size(600, 600);
  timesPreached = 0;
  jesus = loadImage("jesus.jpg");
  jesus.resize(220, 300);
  
  day = day();
  month = month();
  year = year();
  date = String.valueOf(month) + "/" + String.valueOf(day) + "/" + String.valueOf(year);
  bttn1 = 100;
  bttn2 = 100;
  checkin = false;
}

void draw(){
  background(0);
  image(jesus, 10, 10);
  fill(100);
  stroke(100);
  textSize(30);
  text("Times Preached:", (width/2)-50, (height/2)-75);
  textSize(100);
  text(timesPreached, (width/2)-25, (height/2)+25);
  fill(0);
  
  if(((mouseX >= 100 && mouseX <= 500) && (mouseY >= 450 && mouseY <= 500))){//end of class button
    bttn1Stroke = 3;
    if(mousePressed){
      if(!checkin){
        println("No arrival time logged...");
        println("Logging arrival time as 'UNCLOCKED'");
        timeArrived = "UNCLOCKED";
        checkin = true;
        mousePressed = false;
      }else{
        write = true;
        String fileName = "scoreBoard.txt";
        //Write text to file
        appendTextToFile(fileName, "\nTimes Preached: " + timesPreached + " - " + date + "\n Arrived At: " + timeArrived + "\n Minutes Late: " + timeLate);
        mousePressed = false;
      }
    } else {
      write = false;
      bttn1 = 200;
    }
  } else if(((mouseX >= 100 && mouseX <= 500) && (mouseY >= 520 && mouseY <= 570))){//arrival button
    bttn2Stroke = 3;
    bttn2 = 200;
    if(mousePressed){
      String hour, minute;
      hour = str(hour());
      minute = str(minute());
      if(int(minute) < 10){
        minute = "0" + minute;
      }
      timeArrived = hour + ":" + minute;
      timeLate = str(int(minute) - 30);
      println("Time Saved As: " + timeArrived + "\nMinutes Late: " + timeLate);
      checkin = true;
      mousePressed = false;
    }
  } else {
    bttn1 = 100;
    bttn2 = 100;
    bttn1Stroke = 1;
    bttn2Stroke = 1;
    if (mousePressed && (mouseButton == RIGHT)){
      timesPreached--;
      mousePressed = false;
    } else if (mousePressed && (mouseButton == LEFT)){
      timesPreached++;
      mousePressed = false;
    }
  }
  strokeWeight(bttn1Stroke);
  stroke(bttn1);
  rect(100, 450, 400, 50);
  strokeWeight(bttn2Stroke);
  stroke(bttn2);
  rect(100, 520, 400, 50);
  fill(200);
  textSize(40);
  text("End Of Class", 180, 490);
  text("Jesus Has Arrived", 140, 560);
}

//File handling functions
void appendTextToFile(String filename, String text){
  File f = new File(dataPath(filename));
  if(!f.exists()){
    createFile(f);
  }
  try {
    PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(f, true)));
    out.println(text);
    out.close();
    exit();
  } catch (IOException e) {
      e.printStackTrace();
  }
}

void createFile(File f){
  File parentDir = f.getParentFile();
  try{
    parentDir.mkdirs(); 
    f.createNewFile();
  }catch(Exception e){
    e.printStackTrace();
  }
}