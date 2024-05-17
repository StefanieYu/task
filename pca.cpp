#include <iostream>
#include <stdlib.h>
#include "matrix.h"
#include <map>
 
using namespace std;
 
/**
* @brief 求实对称矩阵的特征值及特征向量的雅克比法
* 利用雅格比(Jacobi)方法求实对称矩阵的全部特征值及特征向量
* @param pMatrix                长度为n*n的数组，存放实对称矩阵
* @param nDim                   矩阵的阶数
* @param pdblVects              长度为n*n的数组，返回特征向量(按列存储)
* @param dbEps                  精度要求
* @param nJt                    整型变量，控制最大迭代次数
* @param pdbEigenValues         特征值数组
* @return
*/
bool JacbiCor(double * pMatrix,int nDim, double *pdblVects, double *pdbEigenValues, double dbEps,int nJt)
{
 
}
//mean 均值 pdblVects特征向量 pdbEigenValues特征值 k为取前k个
void pca(Matrix mean,Matrix pdblVects, int k, vector<double>&meanVal)
{
    if (k > mean.row || k < 0)
    {
        cout<<"error"<<endl;
        exit(0);;
    }
    Matrix pcaVects;
    pcaVects.initMatrix(&pcaVects,mean.row,k);
    for (int i = 0; i < k; i++)
    {
         pcaVects = pcaVects.getOneRow(pdblVects,i);
    }
    pcaVects.print(pcaVects);
 
    Matrix lowData;
    //cout<<endl;
    lowData.initMatrix(&lowData,mean.col,pcaVects.row);
    //mean.print(mean);
    //cout<<endl;
    //转换成低维数据
    lowData.multsmatrix(&lowData,mean,pcaVects);
    lowData.print(lowData);
    //需要转换到相同的坐标里面
    Matrix reconMat;
    reconMat.initMatrix(&reconMat, mean.col,mean.row);
    Matrix pcaVectsT;
    pcaVectsT.initMatrix(&pcaVectsT,k,mean.row);
    pcaVectsT.transposematrix(pcaVects,&pcaVectsT);//转置
    reconMat.multsmatrix(&reconMat,lowData,pcaVectsT);
    //cout<<endl;
    //reconMat.print(reconMat);
    //加上平均值
    for (int i = 0; i < reconMat.col; i++)
    {
        for (int j = 0; j < reconMat.row; j++)
        {
            reconMat.mat[i][j] += meanVal[j];
        }
    }
    //cout<<endl;
    reconMat.print(reconMat);
}
 
int main()
{
    dataToMatrix dtm;
    char file[30]="G:/data/pca.txt";
    dtm.loadData(&dtm,file);
    Matrix x;
    x.loadMatrix(&x,dtm);
 
    Matrix result;
    vector<double>meanVal;//存放均值，在降维数据之后，映射到原坐标有用到
    result = result.covMatrix(x,meanVal);
//    cout<<endl;
//    result.print(result);
//    cout<<endl;
    double *pMatrix = new double[result.row * result.row];
    for (int i = 0; i < result.row; i++)
    {
        for (int j = 0; j < result.row; j++)
        {
            pMatrix[i * result.row + j] = result.mat[i][j];
        }
    }
    double *pdblVects = new double[result.row * result.row];
    double *pdbEigenValues = new double[result.row];
    bool a = JacbiCor(pMatrix,2, pdblVects, pdbEigenValues, 0.0001,10000);
 
    //将数组转换到矩阵里面
    Matrix vectsMatrix;
    vectsMatrix.initMatrix(&vectsMatrix,result.row,result.row);
    for (int i = 0; i < result.row; i++)
    {
        for (int j = 0; j < result.row; j++)
        {
            vectsMatrix.mat[i][j] = pdblVects[i * result.row + j];
        }
    }
    vectsMatrix.print(vectsMatrix);
    pca(x,vectsMatrix, 1, meanVal);
    return 0;
}