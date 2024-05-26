#include <iostream>

struct Data{
    int value;
    int key;
    bool operator<(const Data& data){
        return this->value <= data.value;//非递减
    }
};

void merge(Data array[],Data tempArray[],int left,int right,int middle){
    int index = left,index1,index2;
    for(int i = left;i <= right;i++)
        tempArray[i] = array[i];
    for(index1 = left,index2 = middle+1;index1 <= middle&&index2 <=right;){
        if(tempArray[index1] < tempArray[index2])
            array[index++] = tempArray[index1++];
        else
            array[index++] = tempArray[index2++];
    }
    while(index1 <= middle)
        array[index++] = tempArray[index1++];
    while(index2 <= right)
        array[index++] = tempArray[index2++];       
}

void mergeSort(Data array[],Data tempArray[],int left,int right){
    if(left < right){
        int middle = (left+right)/2;
        mergeSort(array,tempArray,left,middle);
        mergeSort(array,tempArray,middle+1,right);
        merge(array,tempArray,left,right,middle);
    }
}

int main(){
    int n;
    std::cin >> n;
    Data* data = new Data[n];
    Data* array = new Data[n];
    for(int i = 0;i < n;i++)
        std::cin >> data[i].value >> data[i].key;
    mergeSort(data,array,0,n-1);
    for(int i = 0;i < n;i++)
        std::cout << data[i].value << " " << data[i].key << std::endl;

    return 0;
}