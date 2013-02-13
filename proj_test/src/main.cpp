#include <iostream>
#include "Pool.hpp"

using namespace std;

int main() {
	
	int * t[128];
	
	Pool<int>::instance()->setSize(10);
	
	for ( int i = 0 ; i < 16 ; ++i ) {
		t[i] = Pool<int>::instance()->get();
		*t[i] = i;
		cout << *t[i] << " ";
	}
	
	cout << endl << "give back" << endl;
	
	for ( int i = 0 ; i < 16 ; ++i ) {
		Pool<int>::instance()->give_back(t[i]);
	}
	
	cout << "get :" << endl;
	
	for ( int i = 0 ; i < 16 ; ++i ) {
		t[i] = Pool<int>::instance()->get();
		cout << *t[i] << " " << "(" 
			 << Pool<int>::instance()->size() 
			 << ") ";
	}
	
	for ( int i = 0 ; i < 16 ; ++i ) {
		Pool<int>::instance()->give_back(t[i]);
	}
	
	cout << endl;
	
	Pool<int>::instance()->clear();
	cout << "clear : " << Pool<int>::instance()->size() << endl;
	
	//delete Pool<int>::instance();
	
	return 0;
}
