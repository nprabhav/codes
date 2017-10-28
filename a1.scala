object binsearch
{
	def bins(arr:Array[Int],l:Int,r:Int,x:Int):Int = 
	{	
		if(l > r)
		{return -1;}
		else
		{
			var mid=l+(r-l)/2;
			if(arr(mid)==x)
			{return mid;}
			else if(arr(mid)>x)
			{return bins(arr,l,mid-1,x);}
			else 
			{return bins(arr,mid+1,r,x);}
		}

	}


	def main(args:Array[String])
	{
		println("Enter size of array");
		var n=readInt
		println("Enter array elements")
		var a=new Array[Int](n);
		for(i<-0 to n-1)
			a(i)=readInt
		a=a.sorted
		println("Enter element");
		var x=readInt
		var index = bins(a,0,n-1,x);
		if(index == -1){
		 	println("Element not found");
		 }
		 else{
		 	println("Found at "+index);
		 }	
	}
}
