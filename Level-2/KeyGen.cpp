#include<bits/stdc++.h>

using namespace std;
int main()
{
	string a = "ckfaocrkeuwxyrskpblwfkllfxxkbkiefkydgxokixawjweckcwbxqwwqnyeyrkklronkyboobqwquoboipurckfaoqnwyexjklkrqlwysomexiefkyvwktluuocoykejxcwwreeyuskvkoomwxqlooippxeywriuwgbqykeomwsnopbeqoypwellkelrirggreeyuskvkowxprelgmobkargimonwowsqqolrxxkyeqtouoocurerencygnrxykojeakjyxoprxb";
	int key_size;
	float f[26]={0.812,0.149,0.271,0.432,1.202,0.23,0.203,0.592,0.731,0.01,0.069,0.398,0.261,0.695,0.768,0.182,0.011,0.602,0.628,0.91,0.288,0.111,0.209,0.017,0.211,0.007};
	printf("Enter the expected key size:");
	scanf("%d",&key_size);
	int key[key_size];
	for(int z=0;z<key_size;++z)
	{
		string b;
		for(int i=z;i<a.length();i=i+key_size)
		{
			b.push_back(a[i]);
		}
		float f2[26]={0};
		for(int i=0;i<a.length();i++)
		{
			f2[b[i]-'a']++;
		}
		
		for(int i=0;i<26;i++)
		{
			f2[i] = f2[i]/b.length();
		}
		
		float prod,max_prod=0;
		int shift=0,max_shift=0;
		
		for(int i=0;i<25;++i)
		{
			prod=0;
			for(int j=0;j<26;++j)
			{
				prod+=f[j]*f2[j];
			}
			if(prod>max_prod)
			{
				max_prod = prod;
				max_shift = shift;
			}
			float temp = f2[0];
			for(int k=1;k<26;++k)
			{
				f2[k-1] = f2[k];
			}
			f2[25] = temp;
			shift++;
		}
		key[z]=max_shift;
	}
	printf("key = [ ");
	for(int i=0;i<key_size;++i)
	{
		printf("%c ",key[i]+97);
	}
	printf("]\n");
	return 0;
}