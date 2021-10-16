//C Wine Package Manager

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/stat.h>
int sync();
int list();
int install(char[]);

int main(int argc, char *argv[])
{
    if (argc > 3 )
    {
        printf ("Too Many Arguments, Try\nwinepkg --help\n");
        return 1;
    }
    if (argc < 2)
    {
        printf ("Not Enough Arguments, Try\nwinepkg --help\n");
    }
    //printf ("%s\n", argv[argc]);
    // help
    if (strcmp(argv[1],"--help")==0)
    {
        printf ("Usage:\nwinepkg -Si <packagename>\nwinepkg -l\n-S    Sync (refresh package lists)\n-i    Install Package\n-l    List Packages\n-Sl   Sync and List Packages\n");
    }
    // sync list
    else if (strcmp(argv[1],"-Sl")==0)
    {
        printf ("Syncing Package Lists ....\n");
        if (sync() == 0)
        {
            printf ("Here are the packages! Run winepkg -l | grep <packagename> to sort them\n");
            list(); printf("\n");
        }

    }
    // sync list install
    else if (strcmp(argv[1],"-Sli")==0)
    {
        printf ("Syncing Package Lists ....\n");
        if (sync() == 0)
        {
            printf ("Here are the packages! Run winepkg -l | grep <packagename> to sort them\n");
            list(); printf("\n");
        }
        install(argv[2]);
    }
    // sync install
    else if (strcmp(argv[1],"-Si")==0)
    {
        printf ("Syncing Package Lists ....\n");
        sync();
        install(argv[2]);
    }
    //sync
    else if (strcmp(argv[1],"-S")==0)
    {
        printf ("Syncing Package Lists ....\n");
        sync();
    }
    //install
    else if (strcmp(argv[1],"-i")==0)
    {
        install(argv[2]);
    }
    //list
    else if (strcmp(argv[1],"-l")==0)
    {
        printf ("Here are the packages! Run winepkg -l | grep <packagename> to sort them\n");
	    list();printf("\n");
    }
    //unrecognised option
    else if (strncmp(argv[1],"-", 1)==0)
    {
        printf ("Argument not found. Run winepkg --help for the list of valid commands\n");
    }
    //no args
    else
    {
        printf ("At least 1 argument is required");
    }
}

int sync()
{
    //gets latest pkglist from github
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
    // cats and sorts pkglist
    if (system("cat ~/.winepkg/pkglist | awk '{ print $1 }'") != 0)
    {
        printf ("File not found. Please run winepkg -S first.\n");
        return 1;
    }
}
int install(char wants[])
{
    //determines what user wants
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
    //printf("%s\n", line);
    char* dlin = strtok(line, " ");
    //dl[0] = pkgname
    //dl[1] = pkg installer
    //dl[2] = pkg files (exe or tarball)
    //dl[3] = pkg runner (sh script that runs wine and stuff)
    char dl[512][512];
    int i = 0;
    while (dlin != NULL) 
    {
      strcpy(dl[i], dlin);
      i++;
      dlin = strtok(NULL, " "); 
    }
    //check if the pkg that is found is correct
    if (strcmp(dl[0],wants)!=0)
    {
        printf ("ERROR couldn't find any matching packages\n");
        return 2;
    }
    //printf ("%s\n", dl[0]);
    //dirname ~/.winepkg/<requested pkg>
    char dirname[512];
    strcpy(dirname,home);
    strcat(dirname,"/.winepkg/");
    strcat(dirname,dl[0]);
    mkdir(dirname, S_IRWXU);
    //idirname = ~/.winepkg/<requested pkg>/installer/
    char idirname[512];
    strcpy(idirname,dirname);
    strcat(idirname,"/installer/");
    mkdir(idirname, S_IRWXU);
    // wgeti = wget installer
    char wgeti[512];
    strcpy(wgeti,"");
    strcat(wgeti, "wget -q --show-progress -N -P ");
    strcat(wgeti,idirname);
    strcat(wgeti," ");
    strcat(wgeti,dl[1]);
    //printf ("%s\n", wgeti);
    system(wgeti);
    // edirname = ~/.winepkg/<requested pkg>/exe/
    char edirname[512];
    strcpy(edirname,dirname);
    strcat(edirname,"/exe/");
    mkdir(edirname, S_IRWXU);
    //wgete = wget executable
    char wgete[512];
    strcpy(wgete,"");
    strcat(wgete, "wget -q --show-progress -N -P ");
    strcat(wgete,edirname);
    strcat(wgete," ");
    strcat(wgete,dl[2]);
    //printf ("%s\n", wgete);
    system(wgete);
    //execi = exec installer
    char execi[512];
    strcpy(execi,"");
    strcat(execi, "cd ");
    strcat(execi, idirname);
    strcat(execi, " && ");
    strcat(execi, "chmod 775 ");
    strcat(execi, idirname);
    strcat(execi, "* && ");
    strcat(execi, "exec ");
    strcat(execi, idirname);
    strcat(execi, dl[0]);
    //printf("%s\n", execi);
    system(execi);
    //wgetr = wget runner script
    char wgetr[512];
    strcpy(wgetr,"");
    strcat(wgetr, "wget -q --show-progress -N -P ");
    strcat(wgetr,dirname);
    strcat(wgetr," ");
    strcat(wgetr,dl[3]);
    //printf ("%s\n", wgetr);
    system(wgetr);
    //chmod = chmod runner
    char chmod[512];
    strcpy(chmod,"");
    strcat(chmod, "chmod 775 ");
    strcat(chmod, dirname);
    strcat(chmod, "/");
    strcat(chmod, dl[0]);
    //printf("%s\n", chmod);
    system(chmod);
    //ask user if they want to install to /usr/bin for easy use
    char ans = 0;
    printf("Would you like to install this program as a command (/usr/bin) [Y/n]");
    while(ans != 'y' && ans != 'n' && ans != '\n') {ans = getchar();}
    if (ans == 'n')
    {
        return 0;
    }
    else if (ans == '\n' || ans == 'y')
    {
        //use sudo (cringe) to install to /usr/bin
        printf ("Installing to /usr/bin Please enter your password\n");
        char inst[512];
        strcpy(inst,"");
        strcat(inst,"sudo ln -sf ");
        strcat(inst,dirname);
        strcat(inst,"/");
        strcat(inst, dl[0]);
        strcat(inst, " /usr/bin/");
        strcat(inst,dl[0]);
        printf("%s\n",inst);
        system(inst);
    }
    else 
    {
        // if user doesnt select y or n or \n  
        printf ("Not Installing To /usr/bin. If you would like this, please re-run this command and type y\n");
        return 2;
    }
    
}


