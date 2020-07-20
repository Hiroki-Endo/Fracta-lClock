final int ITERATIONS = 15; // iteration depth
final float WARP = 1; // iteration speed, used only for iterate()
final float DECAY = 0.7; // ratio between length of consecutive line segments
float L;

void setup()
{
  //size(600, 600);
  fullScreen();
  background(0);
  stroke(255);
  strokeWeight(2);
  frameRate(30);
  L = height / 2 * (1 - DECAY) / (1 - pow(DECAY, ITERATIONS));
}

void draw()
{
  clear();
  pushMatrix();
  iterate(ITERATIONS, width / 2, height / 2, L); // arbitrary speed
  //iterateMinute(ITERATIONS, width / 2, height / 2, L); // 1 rpm
  //iterateHour(ITERATIONS, width / 2, height / 2, L); // 60 rpm
  popMatrix();
}

float angle(float input, int full) {
  return input * 2 * PI / full;
}

void iterate(int iteration, float x, float y, float lth)
{
  if (iteration > 0)
  {
    pushMatrix();
    translate(x, y);
    rotate(angle(minute() * WARP % 60, 60));
    rotate(angle(second() * WARP % 3600, 3600));
    rotate(angle(millis() * WARP % 3600000, 3600000));
    stroke((float)iteration / ITERATIONS * 255, 0, 255 - (float)iteration / ITERATIONS * 255);
    line(0, 0, 0, -lth);
    iterate(--iteration, 0, -lth, lth * DECAY);
    popMatrix();

    pushMatrix();
    translate(x, y);
    rotate(angle(second() * WARP % 60, 60));
    rotate(angle(millis() * WARP % 3600, 3600));
    stroke((float)iteration / ITERATIONS * 255, 0, 255 - (float)iteration / ITERATIONS * 255);
    line(0, 0, 0, -lth);
    iterate(--iteration, 0, -lth, lth * DECAY);
    popMatrix();
  }
}

void iterateMinute(int iteration, float x, float y, float lth)
{
  if (iteration > 0)
  {
    pushMatrix();
    translate(x, y);
    rotate(angle(minute(), 60));
    rotate(angle(second(), 3600));
    rotate(angle(millis(), 3600000));
    stroke((float)iteration / ITERATIONS*255, 0, 255 - (float)iteration / ITERATIONS * 255);
    line(0, 0, 0, -lth);
    iterateMinute(--iteration, 0, -lth, lth * DECAY);
    popMatrix();

    pushMatrix();
    translate(x, y);
    rotate(angle(second(), 60));
    rotate(angle(millis(), 3600));
    stroke((float)iteration / ITERATIONS*255, 0, 255 - (float)iteration / ITERATIONS * 255);
    line(0, 0, 0, -lth);
    iterateMinute(--iteration, 0, -lth, lth * DECAY);
    popMatrix();
  }
}
void iterateHour(int iteration, float x, float y, float lth)
{
  if (iteration > 0)
  {
    pushMatrix();
    translate(x, y);
    rotate(angle(hour(), 12));
    rotate(angle(minute(), 720));
    rotate(angle(second(), 43200));
    rotate(angle(millis(), 43200000));
    stroke((float)iteration / ITERATIONS * 255, 0, 255 - (float)iteration / ITERATIONS * 255);
    line(0, 0, 0, -lth);
    iterateHour(--iteration, 0, -lth, lth * DECAY);
    popMatrix();

    pushMatrix();
    translate(x, y);
    rotate(angle(minute(), 60));
    rotate(angle(second(), 3600));
    rotate(angle(millis(), 3600000));
    stroke((float)iteration / ITERATIONS * 255, 0, 255 - (float)iteration / ITERATIONS * 255);
    line(0, 0, 0, -lth);
    iterateHour(--iteration, 0, -lth, lth * DECAY);
    popMatrix();
  }
}
