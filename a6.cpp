#include<iostream>
#include<math.h>
#define MAX 20
using namespace std;
int main()
{
	int k,n,min=999,cnt=0,xcnt=0,iteration=0;
	float x[MAX],y[MAX],cenx[MAX],ceny[MAX],kc[MAX],kc1[MAX];
	double d[MAX],euc_dist[MAX][MAX];
	cout<<"Enter number of cluster : ";
	cin>>k;
	cout<<"Enter number of objects : ";
	cin>>n;
	cout<<"Enter coordinates of "<<n<<" objects :\n";
	for(int i=0;i<n;i++)
	{
		cout<<"Enter x coordinate : ";
		cin>>x[i];
		cenx[i]=x[i];
		cout<<"Enter y coordinate : ";
		cin>>y[i];
		ceny[i]=y[i];
		kc[i]=kc1[i]=0;	
	}	

	do{
	iteration++;
	/*
	1.calculate eud
	2.compare kc1 and kc
	3.if same cnt++
	4.else update kc1=kc
	5.cal new kc
	6.cal new centroids
	*/
	
	//1
	for(int i=0;i<k;i++)//cluster
		for(int j=0;j<n;j++)//object
				{	
					d[j]=(cenx[i]-x[j])*(cenx[i]-x[j])+(ceny[i]-y[j])*(ceny[i]-y[j]);
					euc_dist[i][j]=sqrt(d[j]);
				}
	int l=0;
	
	//2
	for(int j=0;j<n;j++)
		if(kc[j]==kc1[j])
			l++;
	//3		
	if(l==n)
		cnt++;
	//4
	else
		for(int j=0;j<n;j++)
			kc1[j]=kc[j];
	
	//5
	for(int j=0;j<n;j++)
	{
		for(int i=0;i<k;i++)
			if(euc_dist[i][j]<min)
			{
				min=euc_dist[i][j];
				kc[j]=i;	
			}	
		min=999;
		cenx[j]=ceny[j]=0;
	}
	
	//6
	for(int i=0;i<k;i++)//cluster
	{
		xcnt=0;
		for(int j=0;j<n;j++)//object
		{
			if(kc[j]==i)
			{
				cenx[i]+=x[j];
				ceny[i]+=y[j];
				xcnt++;
			}
		}	
		cout<<"\nThe new centroids are for iteration "<<iteration<<" are :";
		cenx[i]=cenx[i]/xcnt;
		ceny[i]=ceny[i]/xcnt;
		cout<<cenx[i]<<","<<ceny[i]<<"\n";
	}
	
	}while(cnt<2);

	for(int i=0;i<k;i++)
	{
		cout<<"\nCluster "<<i+1<<" centre is : ("<<cenx[i]<<","<<ceny[i]<<")";
		cout<<"\nObjects are: ";
		for(int j=0;j<n;j++)
			if(kc[j]==i)
			{
				cout<<"\n("<<x[j]<<","<<y[j]<<")";
			}			
	}
	
return 0;
}
