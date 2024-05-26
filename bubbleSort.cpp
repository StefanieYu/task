#include <stdio.h>

struct Data{
    int value;
    int key;
    bool operator<(const Data& data){
        return this->value < data.value;//非递减
    }
};

void bubbleSort(Data array[],int n){
    Data temp;
    int isSwap = 0;
    for(int i = 0;i < n;i++){
        isSwap = 0;
        for(int j = n-1;j > i;j--)
            if(array[j] < array[j-1]){
                temp = array[j];
                array[j] = array[j-1];
                array[j-1] = temp;
                isSwap = 1;
            }
        if(!isSwap) break;
    }
}

int main(){
    int n;
    scanf("%d",&n);
    Data *data = new Data[n];
    for(int i = 0;i < n;i++)
        scanf("%d %d",&data[i].value,&data[i].key);
    bubbleSort(data,n);
    for(int i = 0;i < n;i++)
        printf("%d %d\n",data[i].value,data[i].key);

    return 0;