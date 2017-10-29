#include<iostream>
#include<pthread.h>
#include<sched.h>
#include<stdlib.h>
using namespace std;
void* quicksort_thread(void *init);

void swap(int& a, int& b)
{
int temp = a;
a = b;
b = temp;
}

struct qsort_starter
{
    int *array;
    int left;
    int right;
};


int partition(int arr[],int low,int high)
{
	int pivot=arr[high];
	int i=low-1;
	for(int j=low;j<=high-1;j++)
	{
		if(arr[j]<=pivot)
		{
			i++;
			swap(arr[i],arr[j]);
		}
	}
	swap(arr[i+1],arr[high]);
	return i+1;
}
void quicksort(int arr[],int low,int high)
{
	if(low<high)
	{
		int pi=partition(arr,low,high);


		struct qsort_starter arg = {arr,low,pi-1};
            pthread_t thread;
            pthread_t id=pthread_self();
            
            cout<<"Thread number "<<id<<" executing on core "<<sched_getcpu()<<"found pivotElement "<<arr[pi]<<"\n";
            		
            int ret = pthread_create(&thread, NULL, quicksort_thread, &arg);
            
		quicksort(arr,pi+1,high);
		pthread_join(thread, NULL);

	}

}

void* quicksort_thread(void *init)
{
	struct qsort_starter *start = init;
	quicksort(start->array,start->left,start->right);
	return NULL;
}




void print(int a[],int n)
{
	for(int i=0;i<n;i++)
	cout <<"array["<<i<<"] = "<<a[i]<<endl;
}
int main()
{
int n;
cout<<"\nEnter number of elements in array:";
cin>>n;
int test[n];
cout<<"\nNow enter Array ELements: \n";
for(int i=0;i<n;i++)
{cin>>test[i];}
cout << "Before sorting : " << endl;
print(test,n);
quicksort(test,0,n-1);
cout << "After sorting : " << endl;
print(test,n);
return 0;
}
