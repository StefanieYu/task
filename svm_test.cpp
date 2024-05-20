#include<iostream>
#include<opencv.hpp>
using namespace std;
using namespace cv;

int main()
{
	//读取一张手写数字图片(28,28)
	Mat image = cv::imread("shuzi1.jpg", 0);
	Mat img_show = image.clone();
	//更换数据类型有uchar->float32
	image.convertTo(image, CV_32F);
	//归一化
	image = image / 255.0;
	//(1,784)
	image = image.reshape(1, 1);
	
	//加载svm模型
	cv::Ptr<cv::ml::SVM> svm = cv::ml::StatModel::load<cv::ml::SVM>("mnist_svm.xml");
	//预测图片
	float ret = svm->predict(image);
	cout << ret << endl;

	cv::imshow("img", img_show);
	cv::waitKey(0);
	getchar();
	return 0;
}

