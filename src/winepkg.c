//C Wine Package Manager

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <argp.h>
#include <stdbool.h>

#define VERSION "0.3"

int sync();
int list();
int install(char[]);

const char *argp_program_version = VERSION;
static char doc[] = "Wine Package Manager";
static char args_doc[] = "[package name]";
static struct argp_option options[] = {
    { "install", 'i', 0, OPTION_ARG_OPTIONAL, "Install a package" },
    { "list", 'l', 0, OPTION_ARG_OPTIONAL, "List all packages" },
    { "sync", 'S', 0, OPTION_ARG_OPTIONAL, "Sync the package list" },
    {0}
};

struct arguments {
    char *arg_package;
    bool arg_install;
    bool arg_list;
    bool arg_sync;
};

static error_t parse_opt(int key, char* arg, struct argp_state *state){
    struct arguments *args = state->input;
    switch (key) {
        case 'S': 
                args->arg_sync = true;
                break;
        case 'i':
                args->arg_install = true;
                break;
        case 'l':
                args->arg_list = true;
                break;
        case ARGP_KEY_ARG:
            if (state->arg_num >= 1)
                argp_usage(state);
            args->arg_package = arg;
            break;
        default: return ARGP_ERR_UNKNOWN;
    }
    return 0;
}

static struct argp argp = {options, parse_opt, args_doc, doc};

int main(int argc, char *argv[])
{
    struct arguments args;
    int ret = 0;

    args.arg_install = false;
    args.arg_list = false;
    args.arg_sync = false;

    argp_parse(&argp, argc, argv, 0, 0, &args);

    if (args.arg_sync == true)
        ret = sync();
    if (args.arg_list == true)
        ret += list();
    if (args.arg_install == true)
        ret += install(args.arg_package);
    
    return ret;
}

int sync()
{
    printf ("Syncing Package Lists ....\n");
    // get latest pkglist from github
    system("mkdir -p ~/.winepkg/");
    if (system("curl -L http://gamingdoom.github.io/winepkg/pkglist > ~/.winepkg/pkglist") != 0)
    {
        printf ("SERVER NOT FOUND\n");
        return 1;
    }
    return 0;
}    
int list()
{   
    printf ("Here are the packages! Run 'winepkg -l | grep <packagename>' to sort them\n");
    // cats and sorts pkglist
    if (system("cat ~/.winepkg/pkglist | awk '{ print $1 }'") != 0)
    {
        printf ("Package list not found. Please run winepkg -S first.\n");
        return 1;
    }
    return 0;
}
int install(char wants[])
{
    // determine what user wants
    char* home;
    home = getenv("HOME");
    char pl[256];
    strcpy(pl,home);
    strcat(pl,"/.winepkg/pkglist");
    FILE *fp = fopen(pl,"r");
        char line[256];
        while (fgets(line, sizeof(line), fp))
        {
            if (strstr(line, wants)!=NULL)
            {
                break;
            }
        }
    fclose(fp);
    char* dlin = strtok(line, " ");
    /*
     * dl[0] = pkgname
     * dl[1] = pkg installer
     * dl[2] = pkg files (exe or tarball)
     * dl[3] = pkg runner (sh script that runs wine and stuff)
     */
    char dl[512][512];
    int i = 0;

    while (dlin != NULL) 
    {
      strcpy(dl[i], dlin);
      i++;
      dlin = strtok(NULL, " "); 
    }

    // check if the pkg that is found is correct
    if (strcmp(dl[0],wants)!=0)
    {
        printf ("ERROR couldn't find any matching packages\n");
        return 2;
    }

    // dirname ~/.winepkg/<requested pkg>
    char *dirname = malloc((strlen(dl[0]) + strlen(home) + 256)*sizeof(char));
    sprintf(dirname, "%s%s%s", home, "/.winepkg/", dl[0]);
    mkdir(dirname, S_IRWXU);

    // idirname = ~/.winepkg/<requested pkg>/installer/
    char *idirname = malloc((strlen(dirname) + 256)*sizeof(char));
    sprintf(idirname, "%s%s", dirname, "/installer/");
    mkdir(idirname, S_IRWXU);

    // wgeti = wget installer
    char *wgeti = malloc((strlen(dl[1]) + strlen(idirname) + 256)*sizeof(char));
    sprintf(wgeti, "%s%s%s%s", "wget -q --show-progress -N -P ", idirname, " ", dl[1]);
    system(wgeti);

    // edirname = ~/.winepkg/<requested pkg>/exe/
    char *edirname = malloc((strlen(dirname) + 256)*sizeof(char));
    sprintf(edirname, "%s%s", dirname, "/exe/");
    mkdir(edirname, S_IRWXU);

    // wgete = wget executable
    char *wgete = malloc((strlen(dl[2]) + strlen(edirname) + 256)*sizeof(char));
    sprintf(wgete, "%s%s%s%s", "wget -q --show-progress -N -P ", edirname, " ", dl[2]);
    system(wgete);

    // execi = exec installer
    char *execi = malloc((strlen(dl[0]) + 2*strlen(idirname) + 256)*sizeof(char));
    sprintf(execi, "%s%s%s%s%s%s%s", "cd ", idirname, " && chmod 775 ", idirname, "* && exec ", idirname, dl[0]);
    system(execi);

    // wgetr = wget runner script
    char *wgetr = malloc((strlen(dl[3]) + strlen(dirname) + 256)*sizeof(char));
    sprintf(wgetr, "%s%s%s%s", "wget -q --show-progress -N -P ", dirname, " ", dl[3]);
    system(wgetr);

    // Chmod the runner script
    char *chmod = malloc((strlen(dl[0]) + strlen(dirname) + 256)*sizeof(char));
    sprintf(chmod, "%s%s%s%s", "chmod 775 ", dirname, "/", dl[0]);
    system(chmod);

    // Ask user if they want to install to /usr/bin for easy use
    askInstall: printf("Would you like to install this program as a command (/usr/bin) [Y/n]");
    char ans = 0;
    while(ans != 'y' && ans != 'n' && ans != '\n') {ans = getchar();}
    if (ans == 'n')
    {
    }
    else if (ans == '\n' || ans == 'y')
    {
        // Use sudo to install to /usr/bin
        printf("Installing to /usr/bin, please enter your password\n");
        char *inst = malloc((2*strlen(dl[0]) + strlen(dirname) + 256)*sizeof(char));
        sprintf(inst, "%s%s%s%s%s%s", "sudo ln -sf ", dirname, "/", dl[0], " /usr/bin/", dl[0]);
        printf("%s\n",inst);
        system(inst);
        free(inst);
    }
    else 
    {
        // If user doesn't select y or n, ask again
        goto askInstall;
    }

    free(dirname);
    free(idirname);
    free(wgeti);
    free(wgete);
    free(execi);
    free(wgetr);
    free(chmod);

    return 0;
}


