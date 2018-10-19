#include "isr.h"
#include "kernel.h"
#include "../drivers/screen/screen.h"
#include "../lib/string.h"

void print_welcome(){
    kprint("");
    kprint("                               __\n");
    kprint("                           _.-~  )\n");
    kprint("                _..--~~~~,'   ,-/     _\n");
    kprint("             .-'. . . .'   ,-','    ,' )\n");
    kprint("           ,'. . . _   ,--~,-'__..-'  ,'\n");
    kprint("         ,'. . .  (@)' ---~~~~      ,'\n");
    kprint("        /. . . . '~~             ,-'\n");
    kprint("       /. . . . .             ,-'\n");
    kprint("      ; . . . .  - .        ,'\n");
    kprint("     : . . . .       _     /\n");
    kprint("    . . . . .          `-.:\n");
    kprint("   . . . ./  - .          )\n");
    kprint("  .  . . |  _____..---.._/ ___________\n");
    kprint("~---~~~~----~~~~             ~~~~\n");
}

void main() {

    isr_install();
    irq_install();
    print_welcome();
    kprint("Welcome to the Dophin OS\n>");
}

void user_input(char *input) {
    if (strcmp(input, "exit") == 0) {
        kprint("Stopping the CPU. Bye!\n");
        asm volatile("hlt");
    }
    kprint("You said: ");
    kprint(input);
    kprint("\n> ");
}
