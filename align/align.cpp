#include <vector>
#include <stdio.h>
#include <opencv2/opencv.hpp>
#include <sstream>
#include <iostream>
#include "opencv2/core/core.hpp"
#include "opencv2/features2d/features2d.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/nonfree/features2d.hpp"
#include "opencv2/video/video.hpp"
#include "opencv2/opencv.hpp"
#include "opencv2/video/tracking.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include <opencv2/legacy/legacy.hpp>

using namespace cv;
using namespace std;

void printUsage (const char* progName)
{
	std::cout << "\n\nUsage: "<<progName<<" [x1] [y1] [x2] [y2]\n\n"
		<< "Input the coordinates on photo 1 for crop\n"
		<< "Example:\n"
		<< "./align 1 2 1000 1005\n"
		<< "\n\n";
}

int main(int argc, char** argv )
{
	if (argc != 5)
	{
		printUsage(argv[0]);
		return 0;
	}
	istringstream ss1(argv[1]);
	istringstream ss2(argv[2]);
	istringstream ss3(argv[3]);
	istringstream ss4(argv[4]);
	int x1,x2,y1,y2;
	if (!(ss1 >> x1))
		cerr << "Invalid number " << argv[1] << '\n';
	if (!(ss2 >> y1))
		cerr << "Invalid number " << argv[2] << '\n';
	if (!(ss3 >> x2))
		cerr << "Invalid number " << argv[3] << '\n';
	if (!(ss4 >> y2))
		cerr << "Invalid number " << argv[4] << '\n';


	Mat im01 = imread("../1.ppm", CV_LOAD_IMAGE_GRAYSCALE);
	Mat im02 = imread("../2.ppm", CV_LOAD_IMAGE_GRAYSCALE);
	Mat im03 = imread("../3.ppm", CV_LOAD_IMAGE_GRAYSCALE);

	Mat im1,im2,im3;

	Rect ROI1 (x1, y1, x2-x1, y2-y1);

	im1 = im01;
	im2 = im02;
	im3 = im03;

	TermCriteria termcrit(CV_TERMCRIT_ITER|CV_TERMCRIT_EPS, 20, 0.03);
	Size subPixWinSize(10,10), winSize(31,31);
	const int MAX_COUNT = 500;
	vector<Point2f> points[3];

	goodFeaturesToTrack(im1, points[0], MAX_COUNT, 0.01, 10, Mat(), 3, 0, 0.04);
	cornerSubPix(im1, points[0], subPixWinSize, Size(-1,-1), termcrit);

	vector<uchar> status;
	vector<float> err;

	calcOpticalFlowPyrLK(im1, im2, points[0], points[1], status, err, winSize, 3, termcrit, 0, 0.001);

	calcOpticalFlowPyrLK(im1, im3, points[0], points[2], status, err, winSize, 3, termcrit, 0, 0.001);

	Mat RT012 = estimateRigidTransform(points[0], points[1], 0);
	Mat RT013 = estimateRigidTransform(points[0], points[2], 0);

	cout << "RT012 = " << endl << " " << RT012 << endl << endl;
	cout << "RT013 = " << endl << " " << RT013 << endl << endl;

	Rect ROI2 (x1 + int(RT012.at<double>(0,2)), y1 + int(RT012.at<double>(1,2)), x2-x1, y2-y1);
	Rect ROI3 (x1 + int(RT013.at<double>(0,2)), y1 + int(RT013.at<double>(1,2)), x2-x1, y2-y1);

	im1 = im01(ROI1);
	im2 = im02(ROI2);
	im3 = im03(ROI3);

	goodFeaturesToTrack(im1, points[0], MAX_COUNT, 0.01, 10, Mat(), 3, 0, 0.04);
	cornerSubPix(im1, points[0], subPixWinSize, Size(-1,-1), termcrit);

	calcOpticalFlowPyrLK(im1, im2, points[0], points[1], status, err, winSize, 3, termcrit, 0, 0.001);

	calcOpticalFlowPyrLK(im1, im3, points[0], points[2], status, err, winSize, 3, termcrit, 0, 0.001);

	Mat RT112 = estimateRigidTransform(points[0], points[1], 0);
	Mat RT113 = estimateRigidTransform(points[0], points[2], 0);

	cout << "RT112 = " << endl << " " << RT112 << endl << endl;
	cout << "RT113 = " << endl << " " << RT113 << endl << endl;

	Rect ROI21 (x1 + int(RT012.at<double>(0,2)) + int(RT112.at<double>(0,2)), y1 + int(RT012.at<double>(1,2)) + int(RT112.at<double>(1,2)), x2-x1, y2-y1);
	Rect ROI31 (x1 + int(RT013.at<double>(0,2)) + int(RT113.at<double>(0,2)), y1 + int(RT013.at<double>(1,2)) + int(RT113.at<double>(1,2)), x2-x1, y2-y1);

	
	im01 = imread("../1.tiff");
	im02 = imread("../2.tiff");
	im03 = imread("../3.tiff");

	im1 = im01(ROI1);
	im2 = im02(ROI21);
	im3 = im03(ROI31);

	imwrite("1.tiff", im1);
	imwrite("2.tiff", im2);
	imwrite("3.tiff", im3);
    return 0;
}
