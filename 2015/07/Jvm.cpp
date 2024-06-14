#include "Jvm.h"
#include "Class.h"
#include <cstdlib>
#include <iostream>

Jvm::Jvm()
  : _vm(NULL)
  , _env(NULL)
{
  JavaVMInitArgs args;
  args.version = JNI_VERSION_1_2;
  args.nOptions = 0;
  args.ignoreUnrecognized = JNI_TRUE;

  if(JNI_CreateJavaVM(&_vm, (void**)&_env, &args) == JNI_ERR)
    throw "error loading jvm";
}

Jvm::~Jvm()
{
  bool ex = _env && (_env->ExceptionCheck() == JNI_TRUE);

  if(_env)
    _env->ExceptionDescribe();
  if(_vm)
    _vm->DestroyJavaVM();

  if(ex)
    exit(1);  
}

void Jvm::clear()
{
  _env->ExceptionClear();
}

std::shared_ptr<Class> Jvm::loadClass(const std::string& name)
{
  jclass cls = _env->FindClass(name.c_str());
  if(! cls)
    throw "loading class";

  return std::shared_ptr<Class>(new Class(_env, cls));
}

