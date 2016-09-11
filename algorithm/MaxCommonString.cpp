#include <iostream>
#inlcude <string>
#include <vector>
using namespace std;

int main(){
	string s1,s2;
	cin>>s1;
	cin>>s2;

	int l1 = s1.size(),l2 = s2.size();
	vector<vector<int> > dp(l1,vector<int>(l2,0));

	for(int i=1; i<=l1; i++){
		for(int j=1; j<l2; j++){
			if(s1[i-1] == s2[j-1])
				dp[i][j] = dp[i-1][j-1]+1;
			else
				dp[i][j] = 0;
		}
	}

	int maxlen = 0;

	for(int i=1; i<=l1; i++)
		for(int j=1; j<=l2; j++)
			if(maxlen<dp[i][j])	maxlen=dp[i][j];
	
	cout<<maxlen<<endl;
	
}

