#include <GL/glut.h>
#include <math.h>

#define PI 3.1416
float carX = 320.0f;
float carY = 86.0f;

float bgScroll = 0.0f;
float skyScroll = 0.0f;

void init() {
    glClearColor(0.5f, 0.8f, 1.0f, 1.0f);
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
    gluOrtho2D(0.0, 640.0, 0.0, 480.0);
}

void drawCircle(float cx, float cy, float r, int segments) {
    glBegin(GL_POLYGON);
    for (int i = 0; i < segments; i++) {
        float theta = 2.0f * PI * float(i) / float(segments);
        float x = r * cosf(theta);
        float y = r * sinf(theta);
        glVertex2f(x + cx, y + cy);
    }
    glEnd();
}

void drawGradientSky() {
    glBegin(GL_QUADS);
    glColor3f(0.0f, 0.4f, 0.8f);
    glVertex2f(0, 480);
    glVertex2f(640, 480);

    glColor3f(0.6f, 0.8f, 1.0f);
    glVertex2f(640, 0);
    glVertex2f(0, 0);
    glEnd();
}

void drawBirds() {
    glPushMatrix();
    glTranslatef(skyScroll, 0, 0);
    glColor3f(0.0f, 0.0f, 0.0f);
    glLineWidth(2.0f);

    float birds[3][2] = { { 400, 400 }, { 430, 420 }, { 380, 410 } };

    for (int i = 0; i < 3; i++) {
        glBegin(GL_LINE_STRIP);
        glVertex2f(birds[i][0], birds[i][1]);
        glVertex2f(birds[i][0] + 10, birds[i][1] - 5);
        glVertex2f(birds[i][0] + 20, birds[i][1]);
        glEnd();
    }
    glPopMatrix();
}

void drawHouseAndBuilding() {
    glPushMatrix();
    glTranslatef(bgScroll, 0, 0);

    float accentR = 0.6f, accentG = 0.2f, accentB = 0.2f;

    // House Base
    glColor3f(0.9f, 0.9f, 0.8f);
    glBegin(GL_QUADS);
    glVertex2f(60, 60);
    glVertex2f(130, 60);
    glVertex2f(130, 110);
    glVertex2f(60, 110);
    glEnd();

    // House Roof
    glColor3f(accentR, accentG, accentB);
    glBegin(GL_TRIANGLES);
    glVertex2f(50, 110);
    glVertex2f(95, 150);
    glVertex2f(140, 110);
    glEnd();

    // House Door
    glColor3f(accentR, accentG, accentB);
    glBegin(GL_QUADS);
    glVertex2f(85, 60);
    glVertex2f(105, 60);
    glVertex2f(105, 90);
    glVertex2f(85, 90);
    glEnd();

    // House Window
    glColor3f(0.6f, 0.8f, 1.0f);
    glBegin(GL_QUADS);
    glVertex2f(70, 95);
    glVertex2f(80, 95);
    glVertex2f(80, 105);
    glVertex2f(70, 105);
    glEnd();

    // Building Base
    glColor3f(0.7f, 0.7f, 0.75f);
    glBegin(GL_QUADS);
    glVertex2f(150, 60);
    glVertex2f(210, 60);
    glVertex2f(210, 180);
    glVertex2f(150, 180);
    glEnd();

    // Building Windows
    glColor3f(accentR, accentG, accentB);
    for (int y = 80; y < 170; y += 30) {
        glBegin(GL_QUADS);
        glVertex2f(160, y);
        glVertex2f(175, y);
        glVertex2f(175, y + 20);
        glVertex2f(160, y + 20);

        glVertex2f(185, y);
        glVertex2f(200, y);
        glVertex2f(200, y + 20);
        glVertex2f(185, y + 20);
        glEnd();
    }
    glPopMatrix();
}

void drawSun() {
    glPushMatrix();
    glTranslatef(skyScroll, 0, 0);

    float sx = 550.0f;
    float sy = 420.0f;

    glColor3f(1.0f, 0.8f, 0.0f);
    glLineWidth(2.0f);
    glBegin(GL_LINES);
    for (int i = 0; i < 12; i++) {
        float theta = 2.0f * PI * i / 12.0f;
        glVertex2f(sx + 45 * cos(theta), sy + 45 * sin(theta));
        glVertex2f(sx + 60 * cos(theta), sy + 60 * sin(theta));
    }
    glEnd();

    glColor3f(1.0f, 0.9f, 0.0f);
    drawCircle(sx, sy, 40.0f, 30);
    glPopMatrix();
}

void drawClouds() {
    glPushMatrix();
    glTranslatef(skyScroll, 0, 0);
    glColor3f(1.0f, 1.0f, 1.0f);

    float c1x = 200.0f;
    float c1y = 380.0f;
    drawCircle(c1x, c1y, 25.0f, 20);
    drawCircle(c1x + 25, c1y + 10, 30.0f, 20);
    drawCircle(c1x + 50, c1y, 25.0f, 20);

    float c2x = 350.0f;
    float c2y = 350.0f;
    drawCircle(c2x, c2y, 25.0f, 20);
    drawCircle(c2x + 30, c2y + 15, 35.0f, 20);
    drawCircle(c2x + 60, c2y, 25.0f, 20);
    glPopMatrix();
}

void drawMountains() {
    glPushMatrix();
    glTranslatef(bgScroll * 0.5f, 0, 0);

    glBegin(GL_TRIANGLES);

    // Mountain Bases
    glColor3f(0.5f, 0.35f, 0.05f);
    glVertex2f(0, 60); glVertex2f(150, 280); glVertex2f(300, 60);
    glVertex2f(200, 60); glVertex2f(400, 320); glVertex2f(600, 60);
    glVertex2f(500, 60); glVertex2f(650, 250); glVertex2f(800, 60);

    // Snow Caps
    glColor3f(1.0f, 1.0f, 1.0f);
    glVertex2f(116, 230); glVertex2f(150, 280); glVertex2f(184, 230);
    glVertex2f(354, 260); glVertex2f(400, 320); glVertex2f(446, 260);
    glVertex2f(611, 200); glVertex2f(650, 250); glVertex2f(689, 200);

    glEnd();
    glPopMatrix();
}

void drawTrees() {
    glPushMatrix();
    glTranslatef(bgScroll, 0, 0);

    float treeX[2] = { 450.0f, 580.0f };

    for (int i = 0; i < 2; i++) {
        float tx = treeX[i];
        float ty = 60.0f;

        // Trunk
        glColor3f(0.4f, 0.2f, 0.1f);
        glBegin(GL_QUADS);
        glVertex2f(tx - 10, ty);
        glVertex2f(tx + 10, ty);
        glVertex2f(tx + 10, ty + 40);
        glVertex2f(tx - 10, ty + 40);
        glEnd();

        // Leaves
        glColor3f(0.1f, 0.4f, 0.1f);
        glBegin(GL_TRIANGLES);
        glVertex2f(tx - 30, ty + 40); glVertex2f(tx, ty + 90); glVertex2f(tx + 30, ty + 40);
        glVertex2f(tx - 25, ty + 65); glVertex2f(tx, ty + 110); glVertex2f(tx + 25, ty + 65);
        glVertex2f(tx - 15, ty + 90); glVertex2f(tx, ty + 130); glVertex2f(tx + 15, ty + 90);
        glEnd();
    }
    glPopMatrix();
}

void drawRoad() {
    glColor3f(0.3f, 0.3f, 0.3f);
    glBegin(GL_QUADS);
    glVertex2f(0, 0); glVertex2f(640, 0);
    glVertex2f(640, 60); glVertex2f(0, 60);
    glEnd();

    glColor3f(1.0f, 1.0f, 1.0f);
    float offset = fmod(bgScroll, 40.0f);
    for (int i = -40; i < 680; i += 40) {
        glBegin(GL_QUADS);
        glVertex2f(i + offset, 28);
        glVertex2f(i + 20 + offset, 28);
        glVertex2f(i + 20 + offset, 32);
        glVertex2f(i + offset, 32);
        glEnd();
    }
}

void drawCar() {
    glPushMatrix();
    glTranslatef(carX, carY, 0.0f);
    glScalef(0.7f, 0.7f, 1.0f);

    // Car Body Bottom
    glColor3f(0.0f, 0.5f, 0.6f);
    glBegin(GL_POLYGON);
    glVertex2f(-60, -20); glVertex2f(60, -20);
    glVertex2f(60, 20); glVertex2f(-60, 20);
    glEnd();

    // Car Body Top
    glColor3f(0.8f, 0.5f, 0.6f);
    glBegin(GL_POLYGON);
    glVertex2f(-30, 20); glVertex2f(30, 20);
    glVertex2f(20, 50); glVertex2f(-20, 50);
    glEnd();

    // Windows
    glColor3f(0.6f, 0.8f, 1.0f);
    glBegin(GL_POLYGON);
    glVertex2f(-25, 25); glVertex2f(-5, 25);
    glVertex2f(-5, 45); glVertex2f(-18, 45);
    glEnd();

    glBegin(GL_POLYGON);
    glVertex2f(5, 25); glVertex2f(25, 25);
    glVertex2f(18, 45); glVertex2f(5, 45);
    glEnd();

    // Tires
    glColor3f(0.0f, 0.0f, 0.0f);
    drawCircle(-35, -20, 18, 20);
    drawCircle(35, -20, 18, 20);

    // Hubcaps
    glColor3f(0.8f, 0.8f, 0.8f);
    drawCircle(-35, -20, 8, 10);
    drawCircle(35, -20, 8, 10);
    glPopMatrix();
}

void display() {
    glClear(GL_COLOR_BUFFER_BIT);
    drawGradientSky();
    drawMountains();
    drawSun();
    drawClouds();
    drawBirds();
    drawHouseAndBuilding();
    drawTrees();
    drawRoad();
    drawCar();
    glFlush();
    glutSwapBuffers();
}

void specialKey(int key, int x, int y) {
    switch (key) {
        case GLUT_KEY_UP:
            if (carY < 80.0f) carY += 5.0f;
            break;
        case GLUT_KEY_DOWN:
            if (carY > 30.0f) carY -= 5.0f;
            break;
        case GLUT_KEY_RIGHT:
            if (carX < 600.0f) {
                carX += 5.0f;
                bgScroll -= 2.0f;
                skyScroll -= 0.5f;
            }
            break;
        case GLUT_KEY_LEFT:
            if (carX > 40.0f) {
                carX -= 5.0f;
                bgScroll += 2.0f;
                skyScroll += 0.5f;
            }
            break;
    }
    glutPostRedisplay();
}

int main(int argc, char** argv) {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB);
    glutInitWindowSize(640, 480);
    glutInitWindowPosition(100, 100);
    glutCreateWindow("CCP CG");
    init();
    glutDisplayFunc(display);
    glutSpecialFunc(specialKey);
    glutMainLoop();
    return 0;
}
