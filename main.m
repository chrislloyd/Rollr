#import <Cocoa/Cocoa.h>
#import <MacRuby/MacRuby.h>

#ifdef DEBUG
  #define MAIN_RB "main.rb"
#else
  #define MAIN_RB "main.rbo"
#endif

int main(int argc, char *argv[])
{
  return macruby_main(MAIN_RB, argc, argv);
}
