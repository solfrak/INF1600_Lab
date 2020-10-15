#include "exo1.h"

//TODO
uint32_t toBigEndian(uint32_t value) {
    uint32_t sortie = (value & 0x000000FF) << 24 | (value & 0x0000FF00) << 8 | (value & 0x00FF0000) >> 8 | (value &0xFF000000) >> 24;
    return sortie;
}

//TODO
uint32_t convertToInteger(uint8_t* bytes){
    uint32_t sortie = (bytes[0]<<24 | bytes[1] << 16 | bytes[2] << 8 | bytes[3]);
    return sortie;
}

//TODO
uint8_t* convertToBytes(uint32_t value){
    uint8_t* sortie = new uint8_t[4];
    sortie[0] = (value & (0xFF << 24)) >> 24;
    sortie[1] = (value & (0xFF <<16)) >> 16;
    sortie[2] = (value & (0xFF << 8)) >> 8;
    sortie[3] = (value & (0xFF));
    return sortie;
}

int main()
{
    
    int size; 
    uint32_t* tableau_32bits = lireFichier("x.gif", size, convertToInteger);
    uint32_t* resultat_sortie = new uint32_t[size];

    //TODO
     for(int i = 0; i <size; i++)
    {
        resultat_sortie[i] = toBigEndian(tableau_32bits[i]);
    }

    ecrireFichier("x-decode.gif", resultat_sortie, size, convertToBytes);
    delete[] resultat_sortie;
    delete[] tableau_32bits;
    runTests(toBigEndian,convertToInteger,convertToBytes);
    
}