#include "ExceptionCheck.h"

ExceptionCheck::ExceptionCheck(JNIEnv* env)
  : _env(env)
{}

ExceptionCheck::~ExceptionCheck() noexcept(false)
{
  if(_env->ExceptionCheck())
    throw "checked";
}
