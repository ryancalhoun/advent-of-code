#include "Instance.h"
#include "ExceptionCheck.h"
#include "StringArray.h"

Instance::Instance(JNIEnv* env, jclass cls, jobject obj)
  : _env(env)
  , _obj(obj)
  , _eval(env->GetMethodID(cls, "evaluate", "([Ljava/lang/String;)S"))
{
  if(! _eval)
    throw "loading method";
}

Instance::~Instance()
{
  if(_obj)
    _env->DeleteLocalRef(_obj);
}

unsigned short Instance::eval(const std::vector<std::string>& s)
{
  StringArray js(_env, s);
  ExceptionCheck ex(_env);

  return _env->CallShortMethod(_obj, _eval, *js);
}

