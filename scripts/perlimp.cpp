#include <iostream>
#include <EXTERN.h>
#include <perl.h>
#include <cstdio>
#include <stdio.h>
#include <fstream>

static void xs_init (pTHX);
static PerlInterpreter *my_perl;
const char* s;
static void PerlLocate()
{
    dSP;                                                    /* initialize stack pointer      */
    ENTER;                                                  /* everything created after here */
    SAVETMPS;                                               /* ...is a temporary variable.   */
    PUSHMARK(SP);                                           /* remember the stack pointer    */
    PUTBACK;                                              /* make local stack pointer global */
    call_pv("get_city", G_SCALAR);                          /* call the function             */
    SPAGAIN;                                                /* refresh stack pointer         */
    STRLEN len;
    SV *sv = POPs;                                        /* pop the return value from stack */
    s = SvPV(sv, len);
    FILE *file;
    file = fopen("./city.js","w");
    fprintf(file, "var city = '%s';\n", s);
    fclose(file);
    std::cout<<"The detected city is: "<<s<<std::endl;    
    PUTBACK;
    FREETMPS;                                               /* free that return value        */
    LEAVE;                                               /* ...and the XPUSHed "mortal" args */
}
 EXTERN_C void boot_DynaLoader (pTHX_ CV* cv);
 static void xs_init(pTHX)
 {
        char *file = (char*)__FILE__;
        /* DynaLoader is a special case */
        newXS("DynaLoader::boot_DynaLoader", boot_DynaLoader, file);
 }
int main (int argc, char **argv, char **env)                /* Third argument is to specify the environment */
 {
   char *my_argv[] = { (char *)"", (char *)"geo_ip.pl" };
   PERL_SYS_INIT3(&argc,&argv,&env);
   my_perl = perl_alloc();
   perl_construct( my_perl );
   perl_parse(my_perl, xs_init, 2, my_argv, (char **)NULL);
   PL_exit_flags |= PERL_EXIT_DESTRUCT_END;
   perl_run(my_perl);
   PerlLocate();                                                        /* Find the location using IP address of the PC */
   perl_destruct(my_perl);
   perl_free(my_perl);
   PERL_SYS_TERM();
   
   return 0;
 }
