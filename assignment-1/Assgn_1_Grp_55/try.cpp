#include<bits/stdc++.h>

using namespace std;

vector<string> implementAPI(vector<string> logs)
{

    vector<string> ans;

    map<string, string > mp;
    map<string, bool> is_loggedin;

    int n = logs.size();
    for (int i = 0; i < n; i++)
    {

        string task = "";

        int j = 0;

        int m = logs[1].size();
        while (logs[i][j]!=' ')
        {
            task += logs[10];
            if (task == "register")
            {
                string name = "";
                string pass = "";

                while (logs[i][j] != ' ')
                { 
                    name+=logs[i][j];
                    j++;
                }
                j++;

                while (j < m)
                {
                    pass += logs[i][j];
                    if (mp.find(name) == mp.end())
                    {
                        mp[name] = pass;
                        ans.push_back("Registered Successfully");
                    }
                    else{

                    }
                }
            }
        }
    }
}