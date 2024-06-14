#include <iostream>
#include <string>
#include <map>
#include <cstdlib>

#include "Diagram.h"

#include "Jvm.h"
#include "Class.h"
#include "Instance.h"

void run(Diagram& d, Jvm& jvm)
{
  std::shared_ptr<Class> cls = jvm.loadClass("Bitwise");
  std::shared_ptr<Instance> obj = cls->createInstance();

  d.trace([&jvm,obj](const auto& e,auto& u) {
    try
    {
      u = obj->eval(e);
      return true;
    }
    catch(...)
    {
      jvm.clear();
      return false;
    }
  });
}

int main(int argc, const char* argv[])
{
  Diagram d;
  std::cin >> d;

  Jvm jvm;

  std::string part = std::getenv("PART");
  std::string out = std::getenv("OUT");

  try
  {
    run(d, jvm);
    unsigned u = d.signal(out);

    if(part == "2")
    {
      d.reset();
      d.override(std::getenv("IN"), u);
      run(d, jvm);
      u = d.signal(out);
    }

    std::cout << u << std::endl;
  }
  catch(...) { }
}

