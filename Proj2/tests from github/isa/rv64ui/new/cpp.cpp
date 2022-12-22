#include<test_macros.h>
#include<iostream>
#include<fstream>
#include<cstring>
using namespace std;

int main() {
	TEST_LD_OP(2, lb, 0xffffffffffffffff, 0, tdat);
	TEST_LD_OP(3, lb, 0x0000000000000000, 1, tdat);
	TEST_LD_OP(4, lb, 0xfffffffffffffff0, 2, tdat);
	TEST_LD_OP(5, lb, 0x000000000000000f, 3, tdat);
	string file = // output
		ofstream fout;
	fout.open("data.txt");//将fout对象和文件绑定起来（）
	fout << file << endl;
	fout.close();
	return 0;
}