#include <stdio.h>



struct Data{
    int value;
    int key;
    bool operator<=(const Data& data){
        return this->value <= data.value;//非递减
    }
};

void swap(Data& a,Data& b){
    Data temp = a;
    a = b;
    b = temp;
}

int partition(Data array[],int left,int right){
    int l = left,r = right;
    Data temp = array[r];
    while(l != r){
        while(array[l] <= temp&&r > l)
            l++;
        if(l < r)
            array[r--] = array[l];
        while(temp <= array[r]&&r >l)
            r--;
        if(l < r)
            array[l++] = array[r];
    }
    array[l] = temp;
    return l;
}

void quickSort(Data array[],int left,int right){
    if(right <= left)
        return;
    int middle = (left+right)/2;
    swap(array[middle],array[right]);
    middle = partition(array,left,right);
    quickSort(array,left,middle-1);
    quickSort(array,middle+1,right);
}


int main(){
    int n;
    scanf("%d",&n);
    Data *data = new Data[n];
    for(int i = 0;i < n;i++)
        scanf("%d %d",&data[i].value,&data[i].key);
    quickSort(data,0,n-1);
    for(int i = 0;i < n;i++)
        printf("%d %d\n",data[i].value,data[i].key);

    return 0;
}