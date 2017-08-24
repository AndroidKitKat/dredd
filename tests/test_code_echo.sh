#!/bin/sh

# Bash

SOURCE=$(mktemp -t dredd_XXXXXXX.sh)
cat > $SOURCE <<EOF
cat
EOF
echo -n "Testing Bash ... "
curl -F source=@$SOURCE localhost:9206/code/test-echo
rm -f $SOURCE

# Python

SOURCE=$(mktemp -t dredd_XXXXXXX.py)
cat > $SOURCE <<EOF
import sys
for line in sys.stdin:
    print line,
EOF
echo
echo -n "Testing Python ... "
curl -F source=@$SOURCE localhost:9206/code/test-echo
rm -f $SOURCE

# C

SOURCE=$(mktemp -t dredd_XXXXXXX.c)
cat > $SOURCE <<EOF
#include <stdio.h>
#include <stdlib.h>
void main() {
    char buffer[BUFSIZ];
    while (fgets(buffer, BUFSIZ, stdin))
	fputs(buffer, stdout);
}
EOF
echo
echo -n "Testing C ... "
curl -F source=@$SOURCE localhost:9206/code/test-echo
rm -f $SOURCE

# C++

SOURCE=$(mktemp -t dredd_XXXXXXX.cpp)
cat > $SOURCE <<EOF
#include <iostream>
#include <string>
using namespace std;
int main() {
    string line;
    while (getline(cin, line))
	cout << line << endl;
    return 0;
}
EOF
echo
echo -n "Testing C++ ... "
curl -F source=@$SOURCE localhost:9206/code/test-echo
rm -f $SOURCE

# Java

SOURCE=$(mktemp -t dredd_XXXXXXX.java)
cat > $SOURCE <<EOF
import java.util.Scanner;

public class $(basename $SOURCE .java) {
    public static void main(String[] args) {
	Scanner scanner = new Scanner(System.in);
	while (scanner.hasNextLine()) {
	    System.out.println(scanner.nextLine());
	}
	scanner.close();
    }
}
EOF
echo
echo -n "Testing Java ... "
curl -F source=@$SOURCE localhost:9206/code/test-echo
rm -f $SOURCE

# C (Compiler Error)

SOURCE=$(mktemp -t dredd_XXXXXXX.c)
cat > $SOURCE <<EOF
#include <stdio.h>
#include <stdlib.h>
void main() {
    char buffer[BUFSIZ];
    while (fgets(buffer, BUFSIZ, stdin))
	fputs(buffer, stdout)
}
EOF
echo
echo -n "Testing C (Compiler Error)... "
curl -F source=@$SOURCE localhost:9206/code/test-echo
rm -f $SOURCE

# C (Execution Error)

SOURCE=$(mktemp -t dredd_XXXXXXX.c)
cat > $SOURCE <<EOF
#include <stdio.h>
#include <stdlib.h>
int main(int argc, char *argv[]) {
    puts(argv[1000]);
    return 0;
}
EOF
echo
echo -n "Testing C (Execution Error)... "
curl -F source=@$SOURCE localhost:9206/code/test-echo
rm -f $SOURCE

# C (Time Limit)

SOURCE=$(mktemp -t dredd_XXXXXXX.c)
cat > $SOURCE <<EOF
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
int main(int argc, char *argv[]) {
    sleep(100);
    return 0;
}
EOF
echo
echo -n "Testing C (Time Limit)... "
curl -F source=@$SOURCE localhost:9206/code/test-echo
rm -f $SOURCE

# C (Wrong Answer)

SOURCE=$(mktemp -t dredd_XXXXXXX.c)
cat > $SOURCE <<EOF
#include <stdio.h>
#include <stdlib.h>
int main(int argc, char *argv[]) {
    char buffer[BUFSIZ];
    while (fgets(buffer, BUFSIZ, stdin))
	fprintf(stdout, "1%s", buffer);
    return 0;
}
EOF
echo
echo -n "Testing C (Wrong Answer)... "
curl -F source=@$SOURCE localhost:9206/code/test-echo
rm -f $SOURCE

# C (Wrong Formatting)

SOURCE=$(mktemp -t dredd_XXXXXXX.c)
cat > $SOURCE <<EOF
#include <stdio.h>
#include <stdlib.h>
int main(int argc, char *argv[]) {
    char buffer[BUFSIZ];
    while (fgets(buffer, BUFSIZ, stdin))
	fprintf(stdout, " %s", buffer);
    return 0;
}
EOF
echo
echo -n "Testing C (Wrong Formatting)... "
curl -F source=@$SOURCE localhost:9206/code/test-echo
rm -f $SOURCE
