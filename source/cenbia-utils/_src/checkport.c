/*
 * Original from http://stackoverflow.com/questions/10860985/check-port-reachable-in-c
 * checkport.c - check open port. nawawi@rutweb.com
 */

#include <sys/types.h>
#include <sys/socket.h>
#include <signal.h>
#include <netdb.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>

#define CONNECT_TIMEOUT 5 // seconds
static void _alarm(int sig) {
    puts("Timeout!");
    exit(1);
}

int is_up(const char *chkhost, const char *chkport) {
    int sock = -1;
    struct addrinfo * res, *rp;
    int ret = 0;
    char sport[10];
    snprintf(sport, sizeof(sport), "%s", chkport);

    struct addrinfo hints = { .ai_socktype=SOCK_STREAM };

    if (getaddrinfo(chkhost, sport, &hints, &res)) {
        perror("gai");
        return 0;
    }

    for (rp = res; rp && !ret; rp = rp->ai_next) {
        sock = socket(rp->ai_family, rp->ai_socktype, rp->ai_protocol);
        if (sock == -1) continue;
        if (connect(sock, rp->ai_addr, rp->ai_addrlen) != -1) {
            char node[200], service[100];
            getnameinfo(res->ai_addr, res->ai_addrlen, node, sizeof(node), service, sizeof(service), NI_NUMERICHOST);
            //printf("Success on %s, %s\n", node, service);
            ret = 1;
        }
        close(sock);
    }
    freeaddrinfo(res);
    return ret;
}

int main(int argc, char **argv) {
    int ret = 0;
    if (argc != 3) {
        printf("Usage %s: host port\n", argv[0]);
        exit(1);
    }
    signal(SIGALRM, _alarm);
    alarm(CONNECT_TIMEOUT);

    ret = is_up(argv[1], argv[2]);
    printf("%s: %s %s\n", argv[1], argv[2], ( ret == 1 ? "Up" : "Down" ) );
    exit(ret);
}
