#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"

#include <iostream>

using namespace cv;
using namespace std;

int main( int argc, char* argv[] )
{
    VideoCapture capture( CV_CAP_OPENNI );
    Mat depthMap;
    capture >> depthMap;
    imwrite("../dm.ppm", depthMap);
    return 0;
}
