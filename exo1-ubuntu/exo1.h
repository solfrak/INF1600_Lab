#include <string>

extern uint32_t* lireFichier(std::string nomFichier, int& size, uint32_t (*convetToInteger)(uint8_t*));
extern void ecrireFichier(std::string nomFichier, uint32_t* tableau, int size, uint8_t* (*convertToBytes)(uint32_t));
void runTests(uint32_t (*toBigEndian)(uint32_t), uint32_t (*convertToInteger)(uint8_t*), uint8_t* (*convertToBytes)(uint32_t));

uint32_t toBigEndian(uint32_t value);
uint32_t convertToInteger(uint8_t* bytes);
uint8_t* convertToBytes(uint32_t value);