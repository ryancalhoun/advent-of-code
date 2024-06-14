#include "Class.h"
#include "Instance.h"

Class::Class(JNIEnv* env, jclass cls)
  : _env(env)
  , _cls(cls)
  , _constructor(_env->GetMethodID(_cls, "<init>", "()V"))
{
  if(! _constructor)
    throw "constructor";
}

std::shared_ptr<Instance> Class::createInstance()
{
  jobject obj = _env->NewObject(_cls, _constructor);
  if(! obj)
    throw "instance";

  return std::shared_ptr<Instance>(new Instance(_env, _cls, obj));
}
