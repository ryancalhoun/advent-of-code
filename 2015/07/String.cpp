#include "String.h"

String::String(JNIEnv* env, const std::string& s)
  : _env(env)
  , _s(s)
  , _js(env->NewStringUTF(_s.c_str()))
{
  if(! _js)
    throw "string";
}

String::~String()
{
  if(_js)
    _env->DeleteLocalRef(_js);
}

jstring String::operator*()
{
  return _js;
}
