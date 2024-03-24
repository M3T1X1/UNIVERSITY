#include <stdio.h>

typedef struct punkt3D 
{
    double x;
    double y;
    double z;
};

struct punkt3D* pktWiekszy(struct punkt3D* p1, struct punkt3D* p2) 
{
    struct punkt3D* wiekszy = (struct punkt3D*)malloc(sizeof(struct punkt3D));
    
    wiekszy->x = (p1->x > p2->x) ? p1->x : p2->x;
    wiekszy->y = (p1->y > p2->y) ? p1->y : p2->y;
    wiekszy->z = (p1->z > p2->z) ? p1->z : p2->z;

    return wiekszy;
}

int main() 
{
   
    struct punkt3D pkt1 = {3.0, 4.0, 5.5};
    struct punkt3D pkt2 = {1.5, 2.5, 4.0};
    struct punkt3D* wiekszy_pkt = pktWiekszy(&pkt1, &pkt2);

   
    printf("Wspolrzedne wiekszego punktu: x = %f, y = %f, z = %f\n", wiekszy_pkt->x, wiekszy_pkt->y, wiekszy_pkt->z);

    free(wiekszy_pkt);

    return 0;
}
